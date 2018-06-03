# encoding: utf-8
# all the imports
import os
import sys
from flask import Flask, request, g, redirect, url_for, render_template, flash, session
from flaskext.mysql import MySQL
from werkzeug import generate_password_hash, check_password_hash
from contextlib import closing
from functools import wraps

# 解决UTF-8编码问题
reload(sys)
sys.setdefaultencoding('utf-8')

# create application
mysql = MySQL()
app = Flask(__name__)
app.secret_key = 'development key'
# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'VANCIR'
app.config['MYSQL_DATABASE_DB'] = 'school'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)


def login_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        # session.user 保存当前登入会话的用户名
        if 'user' in session:
            return f(*args, **kwargs)
        else:
            flash('请先登录!')
            return redirect(url_for('login'))
    return wrap

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/view', methods=['GET'])
@login_required
def view():
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute('select * from student_info')
    feedback = cursor.fetchall()
    print str(feedback)
    conn.close()
    cursor.close()
    return render_template('view.html', feedback=feedback)


@app.route('/student_choose_course', methods=['GET', 'POST'])
@login_required
def student_choose_course():
    if request.method == 'POST':
        if session['identity'] == "student":
            # 学生提供课程号进行选课
            _courseid = request.form['courseid']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('student_insert_SC', (_courseid))
            feedback = cursor.fetchall()
            conn.close()
            cursor.close()
            return render_template('student_choose_course.html', feedback=feedback)
    return render_template('student_choose_course.html')

@app.route('/student_see_course', methods=['GET', 'POST'])
@login_required
def student_see_course():
    if request.method == 'POST':
        if session['identity'] == "student":
            # 查看session['user']的课程信息及相应成绩学分
            # TODO: student_select_SC是否能确保取得session['user]的信息?
            conn = mysql.connect()
            cursor = conn.cursor()
            # sID, cID, scScore, cCredit
            cursor.callproc('student_select_SC')
            feedback = cursor.fetchall()
            conn.close()
            cursor.close()
            return render_template('student_see_course.html', feedback=feedback)
    return render_template('student_see_course.html')

@app.route('/student_see_termscore', methods=['GET', 'POST'])
@login_required
def student_see_termscore():
    if request.method == 'POST':
        if session['identity'] == "student":
                # 学生提供学期号查看分数
                _term = request.form['term']

                conn = mysql.connect()
                cursor = conn.cursor()
                # cTerm, cID, scSCore
                cursor.callproc('student_select_ctermScore', (_term))
                feedback = cursor.fetchall()
                conn.close()
                cursor.close()
                return render_template('manage.html', feedback=feedback)
    return render_template('student_see_termscore.html')


@app.route('/teacher_choose_course', methods=['GET', 'POST'])
@login_required
def teacher_choose_course():
    if request.method == 'POST':
        if session['identity'] == "teacher":
            # 老师选要教的课
            _courseid = request.form['courseid']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('teacher_insert_TC', (_courseid))
            # cursor.commit()
            feedback = cursor.fetchall()            
            conn.close()
            cursor.close()
            return render_template('teacher_choose_course.html', feedback=feedback)
    return render_template('teacher_choose_course.html')


@app.route('/manage', methods=['GET', 'POST'])
@login_required
def manage():
    error = None
    if request.method == 'POST':
        if session['identity'] == "teacher":
            # 教师身份操作
            if request.form['operation'] == "choose_course":
                _courseid = request.form['courseid']

                conn = mysql.connect()
                cursor = conn.cursor()
                cursor.callproc('teacher_insert_TC', (_courseid))
                feedback = cursor.fetchall()
                # cursor.commit()
                conn.close()
                cursor.close()
                return render_template('manage.html', feedback=feedback)
            # 老师查看自己教的课程
            elif request.form['operation'] == "see_course":
                conn = mysql.connect()
                cursor = conn.cursor()
                # sTC.tID, TC.cID, cTerm
                cursor.callproc('teacher_select_TC')
                feedback = cursor.fetchall()
                conn.close()
                cursor.close()
                return render_template('manage.html', feedback=feedback)
            # 老师录入成绩
            elif request.form['operation'] == "update_course":
                # sID, cID, scScore
                _sid = request.form['sid']  # 学生号
                _cid = request.form['cid']  # 课程号
                _scScore = request.form['scScore']  # 成绩 

                conn = mysql.connect()
                cursor = conn.cursor()
                cursor.callproc('teacher_update_scScore', (_sid, _cid, _scScore))
                feedback = cursor.fetchall()
                # cursor.commit()
                conn.close()
                cursor.close()
                return render_template('manage.html', feedback=feedback)
        # 管理员身份操作
        elif session['identity'] == "admin":
            if request.form['operation'] == "insert_user":
                _uID = request.form['uID']
                _uPassword = request.form['uPassword']
                _uIdentity = request.form['uIdentity']  # 学生为0, 教师为1
                
                conn = mysql.connect()
                cursor = conn.cursor()
                cursor.callproc('admin_insert_user_info', (_uid, _uPassword, _uIdentity))
                feedback = cursor.fetchall()
                # cursor.commit()
                conn.close()
                cursor.close()
                return render_template('manage.html', feedback=feedback)
    return render_template('manage.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        _username = request.form['username']    # 用户提交的用户名
        _password = request.form['password']    # 用户提交的密码
        _identity = request.form['identity']    # 用户选择的登录身份student or teacher or admin
        
        if _identity != "student" and _identity != "teacher" and _identity != "admin":
            error='error'
            flash('身份不合法!')
            return render_template('login.html', error=error)
    
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('sp_validateLogin',(_username,))
        data = cursor.fetchall()

        if len(data) > 0:
            if str(data[0][1]) == _password:
                session['user'] = data[0][0]    # 保存用户名
                session['identity'] = _identity # 保存账户身份信息
                flash('你已成功登入')
                return redirect(url_for('home'))
            else:
                error='error'
                flash('用户名或密码错误!')
                render_template('login.html', error=error)
        else:
            return render_template('login.html', error=error)
    return render_template('login.html', error=error)




@app.route('/signup',methods=['GET','POST'])
def signup():
    error = None
    if request.method == 'POST':
        _username = request.form['username']
        _password = request.form['password']

        if _username and _password: 
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_createUser',(_username, _password, 0, 2222))
            data = cursor.fetchall()

            if len(data) is 0:
                conn.commit()
                cursor.close() 
                conn.close()
                flash('User created successfully !')
                return redirect(url_for('home'))
            else:
                cursor.close() 
                conn.close()
                flash('error: ' + str(data[0]))
                return render_template('signup.html', error=error)
        else:
            flash('Enter the required fields')
            return render_template('signup.html', error=error)
    return render_template('signup.html', error=error)

@app.route('/logout')
def logout():
    session.pop('user', None)
    flash('你已成功登出!')
    return redirect(url_for('home'))


if __name__ == '__main__':
    app.run(debug=True, port=5002)

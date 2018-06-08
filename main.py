# encoding: utf-8
# all the imports
import os
import sys
from flask import Flask, request, g, redirect, url_for, render_template, flash, session
from flaskext.mysql import MySQL
# from werkzeug import generate_password_hash, check_password_hash
from contextlib import closing
from functools import wraps

# 解决UTF-8编码问题
reload(sys)
sys.setdefaultencoding('utf-8')

# create application
mysql = MySQL(autocommit = True)
app = Flask(__name__)
app.secret_key = 'development key'
# MySQL configurations

app.config['MYSQL_DATABASE_DB'] = 'school'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'vancir'
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
    if request.method == 'GET':
        if session['identity'] == "student":
            # 查看session['user']的课程信息及相应成绩学分
            # TODO: student_select_SC是否能确保取得session['user]的信息?
            conn = mysql.connect()
            cursor = conn.cursor()
            print 'suck + ', dir(mysql.connect_args)
            print mysql.connect_args
            # sID, cID, scScore, cCredit
            cursor.callproc('student_select_SC')
            feedback = cursor.fetchall()
            print str(feedback)
            cursor.close()
            conn.close()            
            return render_template('student_see_course.html', feedback=feedback)
    return render_template('student_see_course.html')

@app.route('/student_see_all_course', methods=['GET', 'POST'])
@login_required
def student_see_all_course():
    if request.method == 'GET':
        if session['identity'] == "student":
            # 学生查看所有的课程信息
            # TODO: 编写代码
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('student_select_course_info')
            feedback = cursor.fetchall()
            
            cursor.close()
            conn.close()
            return render_template('student_see_all_course.html', feedback=feedback)
    return render_template('student_see_all_course.html')

@app.route('/student_see_all_student', methods=['GET', 'POST'])
@login_required
def student_see_all_student():
    if session['identity'] == "student":
        # 学生查看所有的学生信息
        # TODO: 编写代码
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('student_select_student_info')
        feedback = cursor.fetchall()

        cursor.close()
        conn.close()
        return render_template('student_see_all_student.html', feedback=feedback)


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
                cursor.callproc('student_select_ctermScore', (str(_term),))
                feedback = cursor.fetchall()
                print "[+] feedback: " + str(feedback)
                cursor.close()
                conn.close()                
                return render_template('student_see_termscore.html', feedback=feedback)
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
            cursor.close()       
            conn.close()
            return render_template('teacher_choose_course.html', feedback=feedback)
    return render_template('teacher_choose_course.html')

@app.route('/teacher_see_course', methods=['GET', 'POST'])
@login_required
def teacher_see_course():
    if request.method == 'GET':
        if session['identity'] == "teacher":
            # 老师查看自己教的课程
            conn = mysql.connect()
            cursor = conn.cursor()
            # TC.tID, TC.cID, cTerm
            cursor.callproc('teacher_select_TC')
            feedback = cursor.fetchall()
            cursor.close()
            conn.close()
            return render_template('teacher_see_course.html', feedback=feedback)
    return render_template('teacher_see_course.html')

@app.route('/teacher_update_scScore', methods=['GET', 'POST'])
@login_required
def teacher_update_scScore():
    if request.method == 'POST':
        if session['identity'] == "teacher":
            # 老师录入成绩
            # sID, cID, scScore
            _sid = request.form['sid']  # 学生号
            _cid = request.form['cid']  # 课程号
            _scScore = request.form['scScore']  # 成绩 

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('teacher_update_scScore', (_sid, _cid, _scScore))
            feedback = cursor.fetchall()
            # cursor.commit()
            cursor.close()
            conn.close()
            return render_template('teacher_update_scScore.html', feedback=feedback)
    return render_template('teacher_update_scScore.html')


@app.route('/teacher_see_all_teacher', methods=['GET'])
@login_required
def teacher_see_all_teacher():
    if session['identity'] == "teacher":
        # 教师查看所有的教师信息
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('admin_select_teacher_info')
        feedback = cursor.fetchall()
        print str(feedback)
        cursor.close()
        conn.close()
        return render_template('teacher_see_all_teacher.html', feedback=feedback)
   

@app.route('/teacher_see_all_student', methods=['GET', 'POST'])
@login_required
def teacher_see_all_student():
    if session['identity'] == "teacher":
        # 教师查看所有的学生信息
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('teacher_select_student_info')
        feedback = cursor.fetchall()

        cursor.close()
        conn.close()
        return render_template('teacher_see_all_student.html', feedback=feedback)


@app.route('/teacher_see_all_score', methods=['GET', 'POST'])
@login_required
def teacher_see_all_score():
    if session['identity'] == "teacher":
        # 教师查看所有的学生成绩
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('teacher_select_SC_info')
        feedback = cursor.fetchall()

        cursor.close()
        conn.close()
        return render_template('teacher_see_all_score.html', feedback=feedback)

@app.route('/admin_see_all_user', methods=['GET', 'POST'])
@login_required
def admin_see_all_user():
    if session['identity'] == "admin":
        # 管理员查看所有的账户
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('admin_select_user_info')
        feedback = cursor.fetchall()

        cursor.close()
        conn.close()
        return render_template('admin_see_all_user.html', feedback=feedback)


@app.route('/admin_see_all_student', methods=['GET', 'POST'])
@login_required
def admin_see_all_student():
    if session['identity'] == "admin":
        # 管理员查看所有的学生信息
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('admin_select_student_info')
        feedback = cursor.fetchall()

        cursor.close()
        conn.close()
        return render_template('admin_see_all_student.html', feedback=feedback)


@app.route('/admin_see_all_teacher', methods=['GET', 'POST'])
@login_required
def admin_see_all_teacher():
    if session['identity'] == "admin":
        # 管理员查看所有的教师信息
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('admin_select_teacher_info')
        feedback = cursor.fetchall()

        cursor.close()
        conn.close()
        return render_template('admin_see_all_teacher.html', feedback=feedback)


@app.route('/admin_see_all_score', methods=['GET', 'POST'])
@login_required
def admin_see_all_score():
    if session['identity'] == "admin":
        # 管理员查看所有的学生成绩
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('admin_select_SC_info')
        feedback = cursor.fetchall()

        cursor.close()
        conn.close()
        return render_template('admin_see_all_score.html', feedback=feedback)


@app.route('/admin_see_all_TC', methods=['GET', 'POST'])
@login_required
def admin_see_all_TC():
    if session['identity'] == "admin":
        # 管理员查看所有的教师授课
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('admin_select_TC_info')
        feedback = cursor.fetchall()

        cursor.close()
        conn.close()
        return render_template('admin_see_all_TC.html', feedback=feedback)

@app.route('/admin_see_all_major', methods=['GET', 'POST'])
@login_required
def admin_see_all_major():
    if session['identity'] == "admin":
        # 管理员查看所有的专业信息
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('admin_select_major_info')
        feedback = cursor.fetchall()

        cursor.close()
        conn.close()
        return render_template('admin_see_all_major.html', feedback=feedback)

@app.route('/admin_see_all_course', methods=['GET', 'POST'])
@login_required
def admin_see_all_course():
    if request.method == 'GET':
        if session['identity'] == "admin":
            # 管理员查看所有的课程信息
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_select_course_info')
            feedback = cursor.fetchall()

            cursor.close()
            conn.close()
            return render_template('admin_see_all_course.html', feedback=feedback)
    return render_template('admin_see_all_course.html')


@app.route('/admin_insert_user', methods=['GET', 'POST'])
@login_required
def admin_insert_user():
    if request.method == 'POST':
        if session['identity'] == "admin":
            # 管理员插入学生或老师网站账号
            _uID = request.form['uID']
            _uPassword = request.form['uPassword']
            _uIdentity = request.form['uIdentity']  # 学生为0, 教师为1
            
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_insert_user_info', (_uID, _uPassword, _uIdentity))
            feedback = cursor.fetchall()
            # cursor.commit()
            conn.close()
            cursor.close()
            flash("用户插入成功")
            return render_template('admin_manage_user.html', feedback=feedback)
    return render_template('admin_manage_user.html')

@app.route('/admin_grant_user', methods=['GET', 'POST'])
@login_required
def admin_grant_user():
    if request.method == 'POST':
        if session['identity'] == "admin":
            # 管理员赋予账号权限
            _grantid = request.form['grantid']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_GRANT_user_access', _grantid)
            feedback = cursor.fetchall()
            # cursor.commit()
            conn.close()
            cursor.close()
            flash("用户赋予权限成功")
            return render_template('admin_manage_user.html', feedback=feedback)
    return render_template('admin_manage_user.html')

@app.route('/admin_revoke_user', methods=['GET', 'POST'])
@login_required
def admin_revoke_user():
    if request.method == 'POST':
        if session['identity'] == "admin":
            # 管理员撤回账号权限
            _revokeid = request.form['revokeid']
            # TODO:     
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_revoke_user_access', (_revokeid))
            feedback = cursor.fetchall()
            # cursor.commit()
            conn.close()
            cursor.close()
            return render_template('admin_manage_user.html', feedback=feedback)
    return render_template('admin_manage_user.html')

@app.route('/admin_add_major', methods=['GET', 'POST'])
@login_required
def admin_add_major():
    if request.method == 'POST':
        if session['identity'] == "admin":
            # 管理员添加专业信息
            _majorid = request.form['majorid']
            _major_name = request.form['major_name']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_insert_major_info', (_majorid, _major_name))
            feedback = cursor.fetchall()
            # cursor.commit()
            cursor.close()
            conn.close()
            flash("信息成功添加到专业信息表内")
            return render_template('admin_add_major.html', feedback=feedback)
    return render_template('admin_add_major.html')

@app.route('/admin_add_course', methods=['GET', 'POST'])
@login_required
def admin_add_course():
    if request.method == 'POST':
        if session['identity'] == "admin":
            # 管理员新建课程信息
            _course_name = request.form['course_name']
            _course_credit = request.form['course_credit']
            _course_term = request.form['course_term']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_insert_course_info', (_course_name, _course_credit, _course_term))
            feedback = cursor.fetchall()
            # cursor.commit()
            conn.close()
            cursor.close()
            flash("信息已成功添加")
            return render_template('admin_add_course.html', feedback=feedback)
    return render_template('admin_add_course.html')

@app.route('/admin_update_course', methods=['GET', 'POST'])
@login_required
def admin_update_course():
    if request.method == 'POST':
        if session['identity'] == "admin":
            # 管理员修改课程信息
            _course_id = request.form['course_id']
            _course_name = request.form['course_name']
            _course_credit = request.form['course_credit']
            _course_term = request.form['course_term']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_update_course_info', (_course_id, _course_name, _course_credit, _course_term))
            feedback = cursor.fetchall()
            # cursor.commit()
            conn.close()
            cursor.close()
            return render_template('admin_update_course.html', feedback=feedback)
    return render_template('admin_update_course.html')

@app.route('/admin_delete_course', methods=['GET', 'POST'])
@login_required
def admin_delete_course():
    if request.method == 'POST':
        if session['identity'] == "admin":
            # 管理员删除课程信息
            _deleteid = request.form['deleteid']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_delete_course_info', (_deleteid))
            feedback = cursor.fetchall()
            # cursor.commit()
            conn.close()
            cursor.close()
            return render_template('admin_delete_course.html', feedback=feedback)
    return render_template('admin_delete_course.html')

@app.route('/admin_update_student', methods=['GET', 'POST'])
@login_required
def admin_update_student():
    if request.method == 'POST':
        if session['identity'] == "admin":
            # 管理员更新学生信息
            _student_id = request.form['student_id']
            _student_major_id = request.form['student_major_id']
            _student_user_id = request.form['student_user_id']
            _student_sex = request.form['student_sex']
            _student_birthday = request.form['student_birthday']
            _student_birthplace = request.form['student_birthplace']
            _student_college = request.form['student_college']
            _student_class = request.form['student_class']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_update_student_info', (_student_id, _student_major_id, _student_user_id, _student_sex, _student_birthday, _student_birthplace, _student_college, _student_class))
            feedback = cursor.fetchall()
            # cursor.commit()
            conn.close()
            cursor.close()
            return render_template('admin_update_student.html', feedback=feedback)
    return render_template('admin_update_student.html')


@app.route('/admin_delete_student', methods=['GET', 'POST'])
@login_required
def admin_delete_student():
    if request.method == 'POST':
        if session['identity'] == "admin":
            # 管理员删除学生信息
            _deleteid = request.form['deleteid']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_delete_student_info', (_deleteid))
            feedback = cursor.fetchall()
            # cursor.commit()
            conn.close()
            cursor.close()
            return render_template('admin_delete_student.html', feedback=feedback)
    return render_template('admin_delete_student.html')

@app.route('/admin_update_teacher', methods=['GET', 'POST'])
@login_required
def admin_update_teacher():
    if request.method == 'POST':
        if session['identity'] == "admin":
            # 管理员更新教师
            _teacher_id = request.form['teacher_id']
            _teacher_major_id = request.form['teacher_major_id']
            _teacher_user_id = request.form['teacher_user_id']
            _teacher_sex = request.form['teacher_sex']
            _teacher_college = request.form['teacher_college']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_update_teacher_info', (_teacher_id, _teacher_major_id, _teacher_user_id, _teacher_sex, _teacher_college))
            feedback = cursor.fetchall()
            # cursor.commit()
            conn.close()
            cursor.close()
            return render_template('admin_update_teacher.html', feedback=feedback)
    return render_template('admin_update_teacher.html')


@app.route('/admin_delete_teacher', methods=['GET', 'POST'])
@login_required
def admin_delete_teacher():
    if request.method == 'POST':
        if session['identity'] == "admin":
            # 管理员删除教师信息
            _deleteid = request.form['deleteid']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('admin_delete_teacher_info', (_deleteid))
            feedback = cursor.fetchall()
            # cursor.commit()
            conn.close()
            cursor.close()
            return render_template('admin_delete_teacher.html', feedback=feedback)
    return render_template('admin_delete_teacher.html')



@app.route('/login', methods=['GET', 'POST'])
def login():
    global mysql
    error = None
    if request.method == 'POST':
        _username = request.form['username']    # 用户提交的用户名
        _password = request.form['password']    # 用户提交的密码
        _identity = request.form['identity']    # 用户选择的登录身份student or teacher or admin
        
        if _identity != "student" and _identity != "teacher" and _identity != "admin":
            error='error'
            flash('身份不合法!')
            return render_template('login.html', error=error)
        print "[+] username: " + _username
        print "[+] password: " + _password
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('sp_validateLogin',(_username,))
        data = cursor.fetchall()
        cursor.close()
        conn.close()

        if len(data) > 0:
            if cmp(str(data[0][1]), _password) == 0:
                session['user'] = data[0][0]    # 保存用户名
                session['identity'] = _identity # 保存账户身份信息
                flash('你已成功登入')

                # create application
                mysql = MySQL(autocommit = True)
                app = Flask(__name__)
                app.secret_key = 'development key'
                # MySQL configurations
                app.config['MYSQL_DATABASE_DB'] = 'school'
                app.config['MYSQL_DATABASE_HOST'] = 'localhost'
                app.config['MYSQL_DATABASE_USER'] = request.form['username'].encode('utf8')
                app.config['MYSQL_DATABASE_PASSWORD'] = request.form['password'].encode('utf8')
                mysql.init_app(app)


                return redirect(url_for('home'))
            else:
                error='error'
                flash('用户名或密码错误!')
                render_template('login.html', error=error)
        else:
            return render_template('login.html', error=error)
    return render_template('login.html', error=error)




# @app.route('/signup',methods=['GET','POST'])
# def signup():
#     error = None
#     if request.method == 'POST':
#         _username = request.form['username']
#         _password = request.form['password']

#         if _username and _password: 
#             conn = mysql.connect()
#             cursor = conn.cursor()
#             # TODO: 这里需要身份和信息表id
#             cursor.callproc('sp_createUser',(_username, _password, 0, 2222))
#             data = cursor.fetchall()

#             if len(data) is 0:
#                 conn.commit()
#                 cursor.close() 
#                 conn.close()
#                 flash('User created successfully !')
#                 return redirect(url_for('home'))
#             else:
#                 cursor.close() 
#                 conn.close()
#                 flash('error: ' + str(data[0]))
#                 return render_template('signup.html', error=error)
#         else:
#             flash('Enter the required fields')
#             return render_template('signup.html', error=error)
#     return render_template('signup.html', error=error)

@app.route('/logout')
def logout():
    session.pop('user', None)
    flash('你已成功登出!')
    return redirect(url_for('home'))


if __name__ == '__main__':
    app.run(debug=True, port=5002)

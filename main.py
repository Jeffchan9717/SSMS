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
app.config['MYSQL_DATABASE_DB'] = 'ssms'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)


def login_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        # session.user 保存当前登入会话的用户名
        if 'user' in session:
            return f(*args, **kwargs)
        else:
            flash('You need to login first.')
            return redirect(url_for('login'))
    return wrap


@app.route('/')
def home():
    return render_template('home.html')


@app.route('/add', methods=['GET', 'POST'])
@login_required
def add():
    if request.method == 'POST':
        if request.form['add'] == "ADD":
            print "[+] " + request.form['sName'], request.form['sMajor']
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute('insert into student (sName, sMajor) values(?,?)',
                       [request.form['sName'], request.form['sMajor']])
            cursor.commit()
            flash('New student information was successfully added')
    return redirect(url_for('add.html'))


@app.route('/view', methods=['GET', 'POST'])
@login_required
def view():
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(
        'select sID, sName, sSex, sBirthday, sBirthPlace, sCollege, sMajor, sEnroll from student')
    feedback = cursor.fetchall()
    conn.close()
    cursor.close()
    return render_template('view.html', feedback=feedback)


@app.route('/search', methods=['GET', 'POST'])
def search():
    if request.method == 'POST':
        if request.form['search'] == "SEARCH":
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(
                'select * from student where sName = ? ', [request.form['s_name']])
            feedback = cursor.fetchall()
            conn.close()
            cursor.close()
            return render_template('view.html', feedback=feedback)
    return render_template('search.html')


@app.route('/delete', methods=['GET', 'POST'])
@login_required
def delete():
    if request.method == 'POST':
        if request.form['delete'] == "DELETE":
            print "[-] " + request.form['d_name']
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute('delete from student where sName = ? ', [
                             request.form['d_name']])
            cursor.commit()
            conn.close()
            cursor.close()
            flash('Sucessfully Deleted')
    return render_template('delete.html')


@app.route('/update', methods=['GET', 'POST'])
@login_required
def update():
    if request.method == 'POST':
        if request.form['update'] == "UPDATE":
            print "[*] " + request.form['u_name'] + request.form['u_major']
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute('update student set sMajor = ? where sName = ? ',
                             [request.form['u_major'], request.form['u_name']])
            cursor.commit()
            conn.close()
            cursor.close()
            flash('Sucessfully Updated')
    return render_template('update.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        _username = request.form['username']
        _password = request.form['password']

        con = mysql.connect()
        cursor = con.cursor()
        cursor.callproc('sp_validateLogin',(_username,))
        data = cursor.fetchall()
        print str(data)

        if len(data) > 0:
            if check_password_hash(str(data[0][1]),_password):
                session['user'] = data[0][0]
                flash('You have logged in successful')
                return redirect(url_for('home'))
            else:
                error='Wrong Eamil address or Password'
                flash('Wrong Email address or Password.')
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
            _hashed_password = generate_password_hash(_password)
            cursor.callproc('sp_createUser',(_username,_hashed_password))
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
    flash('You were logged out')
    return redirect(url_for('home'))


if __name__ == '__main__':
    app.run(debug=True)

# all the imports
import os
import sqlite3
from flask import Flask,request,g,redirect,url_for,render_template,flash,session
from contextlib import closing
from functools import wraps

# create application
app = Flask(__name__)
app.config.from_object(__name__)

# configuration
app.config.update(dict(
    DATABASE=os.path.join(app.root_path, 'ssms.db'),
    DEBUG=True,
    SECRET_KEY='development key',
    USERNAME='admin',
    PASSWORD='default'
))

app.config.from_envvar('SSMS_SETTINGS', silent=True)

def login_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            return f(*args, **kwargs)
        else:
            flash('You need to login first.')
            return redirect(url_for('login'))
    return wrap

def connect_db():
    conn = sqlite3.connect(app.config['DATABASE'])
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    with app.app_context():
        db = get_db()
        with app.open_resource('schema.sql', mode='r') as f:
            db.cursor().executescript(f.read())
        db.commit()

def get_db():
  if not hasattr(g,'sqlite_db'):
     g.sqlite_db=connect_db()
  return g.sqlite_db

@app.teardown_appcontext
def close_db(error):
  if hasattr(g,'sqlite_db'):
     g.sqlite_db.close()

@app.route('/')
def home():
    if request.method=='POST':
        if request.form['opt']=="LOGIN":
            return redirect(url_for('login'))
        if request.form['opt']=="LOGOUT":
            return redirect(url_for('logout'))   
    return render_template('home.html')

@app.route('/add', methods=['GET','POST'])
@login_required
def add():
    if request.method=='POST':
        if request.form['add']=="ADD":
            print "[+] " + request.form['sName'],request.form['sMajor']
            db = get_db()
            db.execute('insert into student (sName, sMajor) values(?,?)', 
                        [request.form['sName'], request.form['sMajor']])
            db.commit()
            flash('New student information was successfully added')
    return redirect(url_for('add.html'))


@app.route('/view',methods=['GET', 'POST'])
@login_required
def view():
     db = get_db()
     cur = db.execute('select sID, sName, sSex, sBirthday, sBirthPlace, sCollege, sMajor, sEnroll from student')
     feedback = cur.fetchall()
     return render_template('view.html', feedback=feedback)


@app.route('/search',methods=['GET','POST'])
def search():
    if request.method=='POST':
        if request.form['search']=="SEARCH":
            db=get_db()
            cur=db.execute('select * from student where sName = ? ', [request.form['s_name']] )
            feedback=cur.fetchall()
            return render_template('view.html', feedback=feedback)
    return render_template('search.html')

@app.route('/delete',methods=['GET','POST'])
@login_required
def delete():
    if request.method=='POST':
        if request.form['delete']=="DELETE":
            print "[-] " + request.form['d_name']
            db=get_db()
            cur=db.execute('delete from student where sName = ? ', [request.form['d_name']] )		
            db.commit()
            flash('Sucessfully Deleted')
    return render_template('delete.html')

@app.route('/update',methods=['GET','POST'])
@login_required
def update():
    if request.method=='POST':
        if request.form['update']=="UPDATE":
            print "[*] " + request.form['u_name'] + request.form['u_major']
            db=get_db()
            cur=db.execute('update student set sMajor = ? where sName = ? ', 
                            [request.form['u_major'], request.form['u_name']] )		
            db.commit()
            flash('Sucessfully Updated')
    return render_template('update.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        if request.form['username'] != app.config['USERNAME']:
            error = 'Invalid username'
        elif request.form['password'] != app.config['PASSWORD']:
            error = 'Invalid password'
        else:
            session['logged_in'] = True
            flash('You were logged in')
            return redirect(url_for('home'))
    return render_template('login.html', error=error)

@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    flash('You were logged out')
    return redirect(url_for('home'))





if __name__=='__main__':
 app.run(debug=True)
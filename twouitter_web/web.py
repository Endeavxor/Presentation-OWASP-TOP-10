from flask import Flask, render_template, request,redirect,session
import mariadb
import sys
import hashlib

app = Flask(__name__,static_url_path='',template_folder='templates',static_folder='static')
app.secret_key = 'your secret key'

# Connect to MariaDB Platform
try:
    conn = mariadb.connect(
        user="root",
        password="my-secret-pw",
        host="twouitter_database",
        port=3306,
        database="twouitter"
    )
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    sys.exit(1)

# Get Cursor
cur = conn.cursor()
conn.autocommit = True;


@app.route('/',methods=['POST','GET'])
def index():
    if not "id" in session.keys():
        return redirect("/login")
    if request.method=="POST":
        cur.execute('INSERT INTO tweets (tweet_text,created_at,user_id) VALUES ("' + request.form["tweetContent"] +'",now(),'+ str(session['id']) +")" )
    cur.execute("SELECT * FROM tweets INNER JOIN users ON user_id=id WHERE user_id<>"+str(session['id'])+" ORDER BY created_at")
    return render_template('twouitter.html',tweets=cur.fetchall())

@app.route('/profil')
def profil():
    cur.execute('SELECT * FROM tweets INNER JOIN users ON user_id=id WHERE user_id=' + str(session['id']))
    return render_template('profil.html',tweets=cur.fetchall())

@app.route('/messages')
def messages():
    # Note : no time to do real messages managment for the presentation
    return render_template('message.html')

@app.route('/account',methods=['GET'])
def account():
    cur.execute('SELECT * FROM users WHERE id="'+request.args.get("userID")+'"')
    account = cur.fetchone()
    return render_template('account.html',userInfo=account)

@app.route('/login',methods=['POST','GET'])
def login():
    if request.method=='POST':
        username = request.form['username']
        password = request.form['password']
        cur.execute('SELECT * FROM users WHERE username="'+username+'" AND password="'+hashlib.sha256(password.encode('utf-8')).hexdigest() +'"')
        account = cur.fetchone()
        if account:
            session['loggedIn']=True
            session['id'] = account[0]
            session['username'] = account[1]
            return redirect("/profil")
        else:
            return redirect(request.referrer)
    else:
        return render_template("login.html")
        

if __name__ == "__main__":
    app.run()
from flask import Flask
app = Flask(__name__)

@app.route("/admin")
def admin():
    return "<h1>ADMIN</h1>"


@app.route("/")
def home():
    return "Hello from dssd!dshomepage!"

if __name__ == '__main__':
    app.run()

from flask import Flask, render_template
app = Flask(__name__)
  
app.route("/")
def default():
    return "Home Page. Not an error!!" 

@app.route("/<name>")
def home(name):
    return render_template("index.html", content = ["sam","larry","robert"])

  
if __name__ == '__main__':
    app.run()
  
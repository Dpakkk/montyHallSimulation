from flask import Flask, render_template
app = Flask(__name__)
 
@app.route("/login", method = ["POST","GET"])
def login():
    return render_template()

@app.route("/<usr>")
def user(usr):
    return f"<h1>{usr}</h1>"

@app.route("/")
def home():
    return render_template("index.html")
    
@app.route("/anotherone")
def test():
    return render_template("test.html")

if __name__ == '__main__':
    app.run(debug = True)
  
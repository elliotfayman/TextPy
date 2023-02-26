from flask import Flask, render_template, url_for
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)

@app.route('/')
@app.route('/home')
def homepage():
    return render_template("/home.html")

if __name__ == '__main__':
    app.run(debug=True)
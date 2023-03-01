from flask import Flask, render_template, url_for
from flask_restful import Resource, Api
from flask import jsonify

app = Flask(__name__)
api = Api(app)

@app.route('/')
@app.route('/home')
def homepage():
    return render_template("/home.html")


@app.route('/test')
def test():
    return jsonify({'code': 200, 'message': 'Server contacted. Connection successful'})
if __name__ == '__main__':
    app.run(debug=True)
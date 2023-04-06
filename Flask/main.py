from flask import Flask, render_template, url_for, request
from flask_restful import Resource, Api
from flask import jsonify
from twilio import twiml

app = Flask(__name__)
api = Api(app)

@app.route('/')
@app.route('/home')
def homepage():
    return render_template("/home.html")

@app.route('/sms', methods=['POST'])
def sms():
    number = request.form['From']
    message_body = request.form['Body']

    resp = twiml.Response()
    resp.message('Hello {}, you said: {}'.format(number, message_body))
    return str(resp)

@app.route('/test')
def test():
    return jsonify({'code': 200, 'message': 'Server contacted. Connection successful'})

if __name__ == '__main__':
    app.run(debug=True)
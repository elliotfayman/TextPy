"""
A Flask web application that compiles and executes Python code.

Attributes:
    app (Flask): The Flask app object.
    compiler (Compiler): An instance of the Compiler class.
    client (Client): An instance of the Twilio Client class.
    twilio_phone_number (str): Your Twilio phone number in E.164 format.

Routes:
    / (or /home): Renders the home page template.
    /test: Tests the connection to the server.
    /compile: Compiles the code received from the POST request using the Compiler class and returns the output as a JSON response.
    /sms: Receives an SMS message, compiles the code, and sends the output back to the same phone number.

Example Usage:
    Start the server by running this script:
    $ python main.py

    Open your web browser and go to http://localhost:5000 to view the home page.

    To test the server connection, send a GET request to http://localhost:5000/test.

    To compile and execute Python code, send a POST request to http://localhost:5000/compile with the code as the value of the 'code' parameter.

    To receive and compile code from an SMS message, send an SMS to your Twilio phone number in E.164 format.
"""

from flask import Flask, render_template, url_for, request, jsonify
from twilio.rest import Client
from compiler import Compiler

app = Flask(__name__)

compiler = Compiler()
client = Client("**", "**")  # Replace with your Twilio account SID and auth token
twilio_phone_number = "+**"  # Replace with your Twilio phone number in E.164 format

@app.route('/')
@app.route('/home')
def homepage():
    """
    Renders the home page template.
    """
    return render_template('/home.html')

@app.route('/test')
def test():
    """
    Tests the connection to the server.
    """
    return jsonify({'code': 200, 'message': 'Server contacted. Connection successful'})

@app.route('/compile', methods=['POST'])
def compile_code():
    """
    Compiles the code received from the POST request using the Compiler class and returns the output as a JSON response.
    """
    code = request.form['code']
    compiler.set_code(code)
    compiler.compile()
    output = compiler.get_output()
    
    return jsonify({'code': 200, 'message': output})

@app.route('/sms', methods=['POST'])
def sms():
    """
    Receives an SMS message, compiles the code, and sends the output back to the same phone number.
    """
    incoming_message = request.form['Body']
    #print(incoming_message)
    
    compiler.set_code(incoming_message)
    compiler.compile()
    output = compiler.get_output()
    
    message = client.messages.create(
        to=request.form['From'],  # Reply to the same number that sent the message
        from_=twilio_phone_number,
        body=output
    )
    
    return str(message)

if __name__ == '__main__':
    app.run(debug=True)

from flask import Flask, render_template
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)

# in_memory_datastore = { }

@app.route('/messages')
def list_messages():
    return render_template("messages.html")
    # return {"messages":list(in_memory_datastore.values())}

if __name__ == '__main__':
    app.run(debug=True)
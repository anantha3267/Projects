# app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, Dockerized Flask Final Version 10/24/24!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

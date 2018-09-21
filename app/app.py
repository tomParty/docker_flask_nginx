from flask import Flask
from flask_restful import Api


app = Flask(__name__)
api = Api(app)

@app.route("/")
def Home():
    
    resp = "Successfully set up nginx to proxy," + \
        " used supervisor to register nginx and api" + \
        " and keep them alive (restart if crash)," +  \
        " and lastly built a flaskapi. Yama #dockerlife"
    return resp


if __name__ == '__main__':
    app.run(host="0.0.0.0",port=8081)
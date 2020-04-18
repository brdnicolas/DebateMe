import os
from json import dump
from random import randint

from flask import Flask, request, jsonify, render_template, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_marshmallow import Marshmallow
from flask_cors import CORS

# init app
from sqlalchemy import ForeignKey

app = Flask(
    __name__,
    static_folder="./front/dist/static",
    template_folder="./front/dist"
)
basedir = os.path.abspath(os.path.dirname(__file__))

# enable CORS
CORS(app, resources={r'/*': {'origins': '*'}})

user = "DebateMe"
password = "TenezMesBonsDebats"
host = "167.172.57.53"

# export SQLALCHEMY_DATABASE_URI=mysql://DebateMe:TenezMesBonsDebats@167.172.57.53:3306

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://DebateMe:TenezMesBonsDebats@167.172.57.53:3306/DebateMe'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True

db = SQLAlchemy(app)
migrate = Migrate(app, db)
ma = Marshmallow(app)


class Test(db.Model):
    __tablename__ = 'test'
    _id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(300))
    test = db.Column(db.String(500))

    def __init__(self, name, test):
        self.name = name
        self.test = test



class Game(db.Model):
    __tablename__ = 'game'
    _id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(300))
    price = db.Column(db.Float)

    def __init__(self, name, price):
        self.name = name
        self.price = price


class Player(db.Model):
    __tablename__ = 'player'
    _id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(200))
    favorite_game = db.Column(db.Integer, ForeignKey('game._id'))

    def __init__(self, name, favorite_game):
        self.name = name
        self.favorite_game = favorite_game


class GamesSchema(ma.SQLAlchemySchema):
    class Meta:
        model = Game

    _id = ma.auto_field()
    name = ma.auto_field()
    price = ma.auto_field()


class TestsSchema(ma.SQLAlchemySchema):
    class Meta:
        model = Test

    _id = ma.auto_field()
    name = ma.auto_field()
    test = ma.auto_field()


class PlayersSchema(ma.SQLAlchemySchema):
    class Meta:
        model = Player

    _id = ma.auto_field()
    name = ma.auto_field()
    favorite_game = ma.auto_field()


game_schema = GamesSchema()
games_schema = GamesSchema(many=True)

player_schema = PlayersSchema()
players_schema = PlayersSchema(many=True)

test_schema = TestsSchema()
tests_schema = TestsSchema(many=True)


# -------- Routes ----------

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_path(path):
    return render_template('index.html')


@app.route('/test', methods=['GET'])
def all_test():
    temp = Test.query.all()
    dumping = tests_schema.dump(temp)
    return jsonify(dumping)


# sanity check route
@app.route('/ping', methods=['GET'])
def ping_pong():
    return jsonify('pong!')


if __name__ == '__main__':
    app.run(debug=True)

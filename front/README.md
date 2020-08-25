# PLI | DebateMe

# Installation

## 1 - Installation des dépendances :<br><br>
``cd front``<br>
``npm install``<br>
<br>
## 2 - Installation des modules :<br><br>
``pip3 install flask``<br>
``pip3 install flask_sqlalchemy``<br>
``pip3 install flask_marshmallow``<br>
``pip3 install marshmallow-sqlalchemy``<br>
``pip3 install flask_cors``<br>
<br>
## 3 - Importation de App.py et de la base de données :
``cd ../back/``<br>
``python3`` ou ``python``<br>
``from App import *``<br>
``db.create_all()``<br>
<br>
## 4 - Run le serveur : <br>
``cd ../front/``<br>
``npm run serve``<br>

from flask import Flask
from flask_sqlalchemy import SQLAlchemy

class Config:
    SECRET_KEY = 'your-secret-key'  # Cambia con una chiave segreta sicura
    SQLALCHEMY_DATABASE_URI = 'postgresql+pg8000://postgres:Dylan201215!@localhost/Manutenzione'
    SQLALCHEMY_TRACK_MODIFICATIONS = False

# Crea l'app Flask
app = Flask(__name__)
app.config.from_object(Config)

# Inizializza SQLAlchemy
db = SQLAlchemy(app)
 
 
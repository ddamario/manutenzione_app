from config_app import db
from flask_sqlalchemy import SQLAlchemy


class Intervento(db.Model):
    __tablename__ = "interventi"

    id = db.Column(db.Integer, primary_key=True)
    macchina = db.Column(db.String(100), nullable=False)
    priorità = db.Column(db.String(50), nullable=False)
    tipo_intervento = db.Column(db.String(100), nullable=False)
    descrizione = db.Column(db.Text, nullable=False)
    stato = db.Column(db.String(50), default="In Attesa")
    nome_manutentore = db.Column(db.String(100), nullable=True)
    data_creazione = db.Column(db.DateTime, server_default=db.func.current_timestamp())

class RapportoIntervento(db.Model):
    __tablename__ = "rapporti_intervento"

    id = db.Column(db.Integer, primary_key=True)
    intervento_id = db.Column(db.Integer, db.ForeignKey("interventi.id"), nullable=False)
    descrizione = db.Column(db.Text, nullable=False)
    tempo_intervento = db.Column(db.Interval, nullable=True)
    nome_manutentore = db.Column(db.String(100), nullable=True)
    materiali_utilizzati = db.Column(db.Text, nullable=True)
    macchina = db.Column(db.String(100), nullable=False)
    note = db.Column(db.Text, nullable=True)
    data_compilazione = db.Column(db.DateTime, server_default=db.func.current_timestamp())
    costo_ricambi = db.Column(db.Numeric(10, 2))
    causa_del_problema = db.Column(db.Text)
    problema_segnalato = db.Column(db.Text)
    azienda = db.Column(db.String(255))
    ripristino_condizioni_di_pulizia = db.Column(db.Text)
    risoluzione_problema = db.Column(db.Text)
    codice_interno = db.Column(db.Text)

    
class Manutentore(db.Model):
    __tablename__ = 'manutentori'  # Assicurati che il nome sia corretto
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(50), nullable=False)
    cognome = db.Column(db.String(50), nullable=False)

    def __repr__(self):
        return f"<Manutentore {self.nome} {self.cognome}>"


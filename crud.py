from models_app import Intervento, RapportoIntervento
from config_app import db

def aggiungi_intervento(macchina, priorità, tipo_intervento, descrizione, nome_manutentore=None):
    try:
        # Verifica che i campi obbligatori non siano vuoti
        if not macchina or not priorità or not tipo_intervento or not descrizione:
            raise ValueError("Tutti i campi obbligatori devono essere forniti.")

        # Crea il nuovo intervento
        nuovo_intervento = Intervento(
            macchina=macchina,
            priorità=priorità,
            tipo_intervento=tipo_intervento,
            descrizione=descrizione,
            nome_manutentore=nome_manutentore
        )

        # Aggiunge e committa l'intervento al database
        db.session.add(nuovo_intervento)
        db.session.commit()

        return nuovo_intervento

    except Exception as e:
        # Annulla qualsiasi modifica al database in caso di errore
        db.session.rollback()
        print(f"Errore durante l'aggiunta dell'intervento: {e}")
        raise

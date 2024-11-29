from flask import Flask, render_template, request, redirect, url_for, flash, jsonify
from config_app import app, db
from models_app import Intervento, RapportoIntervento, Manutentore
from reportlab.lib.pagesizes import letter, A4
from reportlab.pdfgen import canvas
from textwrap import wrap
from firebase_admin import credentials, messaging
from flask_migrate import Migrate
import firebase_admin
import os
import logging


migrate = Migrate(app, db)

# Configura logging
logging.basicConfig(filename="flask_app.log", level=logging.DEBUG)
app.logger.info("App Flask avviata con successo!")

cred = credentials.Certificate(r"C:\Users\user\Downloads\gestionemanutenzioni-6afbf-c6c594f8d721.json")
firebase_admin.initialize_app(cred)

def invia_notifica_tutti(titolo, messaggio):
    try:
        if tokens:
            result = invia_notifica_tutti.notify_multiple_devices(
                registration_ids=tokens,
                message_title=titolo,
                message_body=messaggio,
            )
            app.logger.info(f"Notifica inviata: {result}")
        else:
            app.logger.warning("Nessun token registrato per inviare notifiche")
    except Exception as e:
        app.logger.error(f"Errore nell'invio della notifica: {e}")


# Memorizzazione token dispositivi
tokens = []

@app.errorhandler(Exception)
def handle_exception(e):
    app.logger.error(f"Errore imprevisto: {e}")
    flash("Si è verificato un errore interno. Contatta l'amministratore.")
    return redirect(url_for("index"))

@app.route("/")
def index():
    try:
        interventi = Intervento.query.filter_by(stato="In Attesa").all()
        app.logger.debug(f"Interventi trovati: {interventi}")
        for i in interventi:
            app.logger.debug(f"Intervento ID: {i.id}, Macchina: {i.macchina}, Stato: {i.stato}, Priorità: {i.priorità}")
        return render_template("index.html", interventi=interventi)
    except Exception as e:
        app.logger.error(f"Errore nella home: {e}")
        flash("Errore durante il caricamento della homepage.")
        return render_template("errore.html"), 500
    
@app.route("/interventi_completati")
def interventi_completati():
    try:
        # Filtra solo gli interventi completati e ordina per data_creazione in ordine decrescente
        interventi = Intervento.query.filter_by(stato="Completato").order_by(Intervento.data_creazione.desc()).all()
        return render_template("interventi_completati.html", interventi=interventi)
    except Exception as e:
        app.logger.error(f"Errore nella pagina interventi completati: {e}")
        flash("Errore durante il caricamento della pagina degli interventi completati.")
        return render_template("errore.html"), 500




@app.route("/nuova_richiesta", methods=["GET", "POST"])
def nuova_richiesta():
    if request.method == "POST":
        try:
            macchina = request.form.get("macchina")
            if not macchina:
                flash("Il campo 'macchina' è obbligatorio.")
                return redirect(url_for("nuova_richiesta"))

            priorità = request.form.get("priorità")
            tipo_intervento = request.form.get("tipo_intervento")
            descrizione = request.form.get("descrizione")
            nome_manutentore = request.form.get("nome_manutentore")

            nuovo_intervento = Intervento(
                macchina=macchina,
                priorità=priorità,
                tipo_intervento=tipo_intervento,
                descrizione=descrizione,
                nome_manutentore=nome_manutentore
            )
            db.session.add(nuovo_intervento)
            db.session.commit()
             # Invia notifica push
            invia_notifica_tutti(f"Nuovo intervento creato: {macchina}", descrizione)
            flash("Nuova richiesta di intervento creata con successo!")
            return redirect(url_for("index"))
        except Exception as e:
            app.logger.error(f"Errore nella creazione della richiesta: {e}")
            flash("Errore durante la creazione della richiesta.")
    return render_template("nuova_richiesta.html")


# Gestione Notifiche Push
# ---------------------
@app.route("/salva_token", methods=["POST"])
def salva_token():
    try:
        token = request.json.get("token")
        if token not in tokens:
            tokens.append(token)
        return jsonify({"message": "Token salvato correttamente"}), 200
    except Exception as e:
        app.logger.error(f"Errore nel salvataggio del token: {e}")
        return jsonify({"error": "Impossibile salvare il token"}), 500


def invia_notifica_tutti(titolo, messaggio):
    try:
        if tokens:
            result = invia_notifica_tutti.notify_multiple_devices(
                registration_ids=tokens,
                message_title=titolo,
                message_body=messaggio,
            )
            app.logger.info(f"Notifica inviata: {result}")
        else:
            app.logger.warning("Nessun token registrato per inviare notifiche")
    except Exception as e:
        app.logger.error(f"Errore nell'invio della notifica: {e}")


@app.route("/compila_rapporto/<int:intervento_id>", methods=["GET", "POST"])
def compila_rapporto(intervento_id):
    intervento = Intervento.query.get_or_404(intervento_id)

    if request.method == "POST":
        try:
            descrizione = request.form.get("descrizione")
            tempo_intervento = request.form.get("tempo_intervento")
            nome_manutentore = request.form.get("nome_manutentore")
            materiali_utilizzati = request.form.get("materiali_utilizzati")
            macchina = request.form.get("macchina")
            note = request.form.get("note")
            costo_ricambi = float(request.form.get("costo_ricambi", 0))
            causa_del_problema = request.form.get("causa_del_problema")
            problema_segnalato = request.form.get("problema_segnalato")
            azienda = request.form.get("azienda")
            ripristino_condizioni_di_pulizia = request.form.get("ripristino_condizioni_di_pulizia")
            codice_interno= request.form.get("codice_interno")
            risoluzione_problema=request.form.get("risoluzione_problema")

            nuovo_rapporto = RapportoIntervento(
                intervento_id=intervento_id,
                descrizione=descrizione,
                tempo_intervento=tempo_intervento,
                nome_manutentore=nome_manutentore,
                materiali_utilizzati=materiali_utilizzati,
                macchina=macchina,
                note=note,
                costo_ricambi=costo_ricambi,
                causa_del_problema=causa_del_problema,
                problema_segnalato=problema_segnalato,
                azienda=azienda,
                ripristino_condizioni_di_pulizia=ripristino_condizioni_di_pulizia,
                codice_interno=codice_interno,
                risoluzione_problema=risoluzione_problema,

            )
            db.session.add(nuovo_rapporto)
            db.session.commit()

            intervento.stato = "Completato"
            db.session.commit()

            flash("Rapporto compilato con successo!")
            return redirect(url_for("genera_pdf", rapporto_id=nuovo_rapporto.id))

        except Exception as e:
            app.logger.error(f"Errore durante la compilazione del rapporto: {e}")
            flash("Si è verificato un errore. Riprova.")
            return redirect(url_for("compila_rapporto", intervento_id=intervento_id))

    return render_template("compila_rapporto.html", intervento=intervento)
@app.route("/genera_pdf/<int:rapporto_id>")
def genera_pdf(rapporto_id):
    try:
        rapporto = RapportoIntervento.query.get_or_404(rapporto_id)
        app.logger.debug(f"Contenuto Rapporto: {rapporto.__dict__}")
        folder_path = os.path.join(os.getcwd(), "rapporti_manutenzione")
        if not os.path.exists(folder_path):
            os.makedirs(folder_path)

        file_path = os.path.join(folder_path, f"rapporto_{rapporto_id}.pdf")

        # Dimensioni pagina e configurazione
        c = canvas.Canvas(file_path, pagesize=A4)
        width, height = A4
        margin_x = 50
        y = height - 50
        line_height = 25
        cell_height = 20

        # Prima Pagina

        # Intestazione principale
        c.setFont("Helvetica-Bold", 14)
        c.drawString(margin_x, y, "RAPPORTO INTERVENTO MANUTENZIONE STRAORDINARIA")
        y -= line_height * 1.5
        c.setFont("Helvetica", 12)
        c.drawString(margin_x, y, f"Rev. 09/2024")
        y -= line_height * 1.5
        
        # Campo Data e Ora
        c.setFont("Helvetica", 12)
        c.drawString(margin_x, y, f"Data e Ora: {rapporto.data_compilazione or 'N/A'}")
        y -= line_height * 1.5

        # Campo: Azienda
        c.drawString(margin_x, y, f"Azienda: {rapporto.azienda or 'N/A'}")
        y -= line_height* 1.5

        # Campo: Macchina
        c.drawString(margin_x, y, f"Macchina: {rapporto.macchina or 'N/A'}")
        y -= line_height * 1.5
        
        # Campo: Manutentore
        c.drawString(margin_x, y, f"Nome Manutentore: {rapporto.nome_manutentore or 'N/A'}")
        y -= line_height * 1.5

        # Campo: Codice Interno
        c.drawString(margin_x, y, f"Codice Interno: {rapporto.codice_interno or 'N/A'}")
        y -= line_height * 1.5

        # Sezione 1: Problema segnalato
        c.setFont("Helvetica-Bold", 12)
        c.drawString(margin_x, y, "1. Descrizione del problema segnalato")
        c.setFont("Helvetica", 10)
        y -= line_height
        if rapporto.problema_segnalato:
            problema_wrapped = wrap(rapporto.problema_segnalato, width=80)  # Regola 'width' in base alla larghezza
            for line in problema_wrapped:
                c.drawString(margin_x, y, line)
                y -= line_height
        else:
                c.drawString(margin_x, y, "N/A")
                y -= line_height * 2


        # Sezione 2: Causa del problema
        
        c.setFont("Helvetica-Bold", 12)
        c.drawString(margin_x, y, "2. Causa del problema")
        c.setFont("Helvetica", 10)
        y -= line_height
        if rapporto.causa_del_problema:
            causa_wrapped = wrap(rapporto.causa_del_problema, width=80)  # Regola 'width' in base alla larghezza
            for line in causa_wrapped:
                c.drawString(margin_x, y, line)
                y -= line_height
        else:
                c.drawString(margin_x, y, "N/A")
                y -= line_height * 2


        # Sezione 3: Descrizione intervento eseguito
        c.setFont("Helvetica-Bold", 12)
        c.drawString(margin_x, y, "3. Descrizione intervento eseguito")
        c.setFont("Helvetica", 10)
        y -= line_height
        if rapporto.descrizione:
            descrizione_wrapped = wrap(rapporto.descrizione, width=80)  # Regola 'width' in base alla larghezza disponibile
            for line in descrizione_wrapped:
                c.drawString(margin_x, y, line)
                y -= line_height
        else:
                c.drawString(margin_x, y, "N/A")
                y -= line_height * 2


        c.showPage()

        # Seconda Pagina
        y = height - 50

        # Campo: Risoluzione Problema
        c.setFont("Helvetica-Bold", 12)
        c.drawString(margin_x, y, f"4. Risoluzione Problema: {rapporto.risoluzione_problema or 'N/A'}")
        y -= line_height * 1.5

        # Campo: Tempo impiegato
        c.setFont("Helvetica-Bold", 12)
        c.drawString(margin_x, y, f"5. Tempo Impiegato: {rapporto.tempo_intervento or 'N/A'}")
        y -= line_height * 2

        # Ripristino Condizioni di Pulizia
        c.setFont("Helvetica-Bold", 12)
        c.drawString(margin_x, y, "6. Ripristino Condizioni di Pulizia:")
        c.setFont("Helvetica", 10)
        y -= line_height
        c.drawString(margin_x, y, rapporto.ripristino_condizioni_di_pulizia or "N/A")
        y -= line_height * 2

        # Materiali utilizzati
        c.setFont("Helvetica-Bold", 12)
        c.drawString(margin_x, y, "7. Materiali utilizzati")
        c.drawString(width - margin_x - 150, y, "Costi Ricambi (euro)")
        y -= line_height
        for materiale in (rapporto.materiali_utilizzati or "N/A").split("\n"):
            c.drawString(margin_x, y, materiale)
            y -= cell_height

        # Totale
        c.drawString(width - margin_x - 100, y + 10, f"7. TOTALE:{rapporto.costo_ricambi or 'N/A'}")
        c.line(width - margin_x - 50, y + 10, width - margin_x, y + 10)
        y -= line_height * 2

        # Note
        c.setFont("Helvetica-Bold", 12)
        c.drawString(margin_x, y, "8. Note e/o Richieste:")
        y -= line_height

        if rapporto.note:
            note_wrapped = wrap(rapporto.note, width=80)  # Regola 'width' in base alla larghezza
            for line in note_wrapped:
                c.drawString(margin_x, y, line)
                y -= cell_height
        else:
            c.drawString(margin_x, y, "N/A")
            y -= line_height


        # Salva il PDF
        c.save()
        return render_template("genera_pdf.html", file_path=file_path, rapporto_id=rapporto_id)

    except Exception as e:
        app.logger.error(f"Errore nella generazione del PDF: {e}")
        flash("Errore nella generazione del PDF.")
        return redirect(url_for("index"))
    
@app.route('/aggiorna/<int:id>', methods=['POST'])
def aggiorna_colonne(id):
    rapporto = RapportoIntervento.query.get(id)
    if rapporto:
        rapporto.risoluzione_problema = "Esempio di risoluzione aggiornata"
        rapporto.codice_interno = "CODICE123"
        db.session.commit()
        return f"Rapporto {id} aggiornato con successo!"
    return "Rapporto non trovato!", 404

if __name__ == '__main__':
    app.run(debug=True)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

#! /usr/bin/python
# -*- coding:utf-8 -*-

# == Importations == #
from flask import Flask, request, render_template, redirect, session, g, flash
import pymysql.cursors

# == Configuration == #
app = Flask(__name__)
app.secret_key = "azerty"


# == Connexion à la base de données == #
def get_db():
    if "db" not in g:
        g.db = pymysql.connect(
            host="localhost",
            user="omaraval",
            password="3112",
            database="BDD_omaraval",
            charset="utf8mb4",
            cursorclass=pymysql.cursors.DictCursor,
        )
    return g.db


# == Déconnexion de la base de données == #
@app.teardown_appcontext
def teardown_db(exception):
    db = g.pop("db", None)
    if db is not None:
        db.close()


################
# == Routes == #
################


@app.route("/")
def show_index():
    return render_template("index.html")


# == Routes appartements == #


# == Routes consommations == #
@app.route("/consommations/show")
def show_consommations():
    mycursor = get_db().cursor()
    sql ='''SELECT id_consomme AS id, date_conso AS date, quantite_consomme AS quantite, libelle_consommable AS type, num_appartement AS appartement
    FROM consomme
    INNER JOIN consommable ON consomme.id_consommable = consommable.id_consommable
    ORDER BY date_conso DESC;'''
    mycursor.execute(sql)
    liste_consommations = mycursor.fetchall()
    return render_template("consommations/show_consommations.html", conso=liste_consommations)

@app.route('/consommations/delete')
def delete_consommations():
    print('''suppression d'une consommation''')
    id=request.args.get('id',0)
    print(id)
    mycursor = get_db().cursor()
    tuple_param=(id)
    sql="DELETE FROM consomme WHERE id_consomme=%s;"
    mycursor.execute(sql,tuple_param)

    get_db().commit()
    print(request.args)
    print(request.args.get('id'))
    id=request.args.get('id',0)
    return redirect('/consommations/show')

@app.route('/consommations/edit', methods=['GET'])
def edit_consommation():
    print('''affichage du formulaire pour modifier une consommation''')
    print(request.args)
    print(request.args.get('id'))
    
    id=request.args.get('id')
    mycursor = get_db().cursor()
    sql = '''SELECT id_consomme AS id, date_conso AS date, quantite_consomme AS quantite, id_consommable AS idc, num_appartement AS appartement
    FROM consomme
    WHERE id_consomme=%s;'''
    tuple_param=(id)
    mycursor.execute(sql,tuple_param)
    consommation = mycursor.fetchone()
    
    sql = '''SELECT id_consommable AS id, libelle_consommable AS type
    FROM consommable'''
    mycursor.execute(sql)
    consommable = mycursor.fetchall()
    
    sql = '''SELECT num_appartement AS num_app
    FROM appartement'''
    mycursor.execute(sql)
    appart = mycursor.fetchall()
    return render_template('consommations/edit_consommation.html', consommation=consommation, consommable=consommable, appart=appart)

@app.route('/consommations/edit', methods=['POST'])
def valid_edit_consommation():
    print('''modification de la consommation dans le tableau''')
    id = request.form.get('id')
    date = request.form.get('date')
    quantite = request.form.get('quantite')
    type = request.form.get('type')
    appartement = request.form.get('appartement')
    message = 'date:' + date + ' - quantite:' + quantite + ' - type:' + type + ' - appartement:' + appartement + ' - pour la consommation d identifiant:' + id
    print(message)
    mycursor = get_db().cursor()
    tuple_param=(date,quantite,type,appartement,id)
    sql="UPDATE consomme SET date_conso = %s, quantite_consomme= %s, id_consommable= %s, num_appartement= %s WHERE id_consomme=%s;"
    mycursor.execute(sql,tuple_param)
    get_db().commit()
    return redirect('/consommations/show')

@app.route('/consommations/add', methods=['GET'])
def add_consommation():
    print('''affichage du formulaire pour saisir un consommable''')

    mycursor = get_db().cursor()
    sql = '''SELECT id_consomme AS id, date_conso AS date, quantite_consomme AS quantite, id_consommable AS idc, num_appartement AS appartement
    FROM consomme'''
    mycursor.execute(sql)
    consommation = mycursor.fetchall()
    
    sql = '''SELECT id_consommable AS id, libelle_consommable AS type
    FROM consommable'''
    mycursor.execute(sql)
    consommable = mycursor.fetchall()
    
    sql = '''SELECT num_appartement AS num_app
    FROM appartement'''
    mycursor.execute(sql)
    appart = mycursor.fetchall()
    return render_template('consommations/add_consommation.html', consommation=consommation, consommable=consommable, appart=appart)

@app.route('/consommations/add', methods=['POST'])
def valid_add_consommation():
    print('''ajout du consommable dans le tableau''')
    date=request.form.get('date')
    quantite=request.form.get('quantite')
    type=request.form.get('type')
    appartement=request.form.get('appartement')
    message = 'date:' + date + ' - quantite:' + quantite + ' - type:' + type + ' - appartement:' + appartement
    print(message)
    mycursor = get_db().cursor()
    tuple_param=(date,quantite, type, appartement)
    sql="INSERT INTO consomme(id_consomme, date_conso, quantite_consomme, id_consommable, num_appartement) VALUES (NULL, %s, %s, %s, %s);"
    mycursor.execute(sql,tuple_param)
    get_db().commit()
    return redirect('/consommations/show')

# == Routes contrats == #

# == Routes locataires == #


#########################
# == Routes Exemples == #
#########################

# @app.route('/')
# @app.route('/etudiant/show')
# def show_etudiants():
#     mycursor = get_db().cursor()
#     sql=''' SELECT id_etudiant AS id, nom_etudiant AS nom, groupe_etudiant AS groupe
#     FROM etudiant
#     ORDER BY nom_etudiant;'''
#     mycursor.execute(sql)
#     liste_etudiants = mycursor.fetchall()
#     return render_template('etudiant/show_etudiants.html', etudiants=liste_etudiants )


# @app.route('/etudiant/add', methods=['GET'])
# def add_etudiant():
#     print('''affichage du formulaire pour saisir un étudiant''')
#     return render_template('etudiant/add_etudiant.html')

# @app.route('/etudiant/delete')
# def delete_etudiant():
#     print('''suppression d'un étudiant''')
#     id=request.args.get('id',0)
#     print(id)
#     mycursor = get_db().cursor()
#     tuple_param=(id)
#     sql="DELETE FROM etudiant WHERE id_etudiant=%s;"
#     mycursor.execute(sql,tuple_param)

#     get_db().commit()
#     print(request.args)
#     print(request.args.get('id'))
#     id=request.args.get('id',0)
#     return redirect('/etudiant/show')

# @app.route('/etudiant/edit', methods=['GET'])
# def edit_etudiant():
#     print('''affichage du formulaire pour modifier un étudiant''')
#     print(request.args)
#     print(request.args.get('id'))
#     id=request.args.get('id')
#     mycursor = get_db().cursor()
#     sql=''' SELECT id_etudiant AS id, nom_etudiant AS nom, groupe_etudiant AS groupe
#     FROM etudiant
#     WHERE id_etudiant=%s;'''
#     tuple_param=(id)
#     mycursor.execute(sql,tuple_param)
#     etudiant = mycursor.fetchone()
#     return render_template('etudiant/edit_etudiant.html', etudiant=etudiant)


# @app.route('/etudiant/add', methods=['POST'])
# def valid_add_etudiant():
#     print('''ajout de l'étudiant dans le tableau''')
#     nom = request.form.get('nom')
#     groupe = request.form.get('groupe')
#     message = 'nom :' + nom + ' - groupe :' + groupe
#     print(message)
#     mycursor = get_db().cursor()
#     tuple_param=(nom,groupe)
#     sql="INSERT INTO etudiant(id_etudiant, nom_etudiant, groupe_etudiant) VALUES (NULL, %s, %s);"
#     mycursor.execute(sql,tuple_param)
#     get_db().commit()
#     return redirect('/etudiant/show')

# @app.route('/etudiant/edit', methods=['POST'])
# def valid_edit_etudiant():
#     print('''modification de l'étudiant dans le tableau''')
#     id = request.form.get('id')
#     nom = request.form.get('nom')
#     groupe = request.form.get('groupe')
#     message = 'nom :' + nom + ' - groupe :' + groupe + ' pour l etudiant d identifiant :' + id
#     print(message)
#     mycursor = get_db().cursor()
#     tuple_param=(nom,groupe,id)
#     sql="UPDATE etudiant SET nom_etudiant = %s, groupe_etudiant= %s WHERE id_etudiant=%s;"
#     mycursor.execute(sql,tuple_param)
#     get_db().commit()
#     return redirect('/etudiant/show')


####################################
# == Lancement de l'application == #
####################################
if __name__ == "__main__":
    app.run(debug=True, port=5000)

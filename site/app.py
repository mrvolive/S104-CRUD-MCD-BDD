#! /usr/bin/python
# -*- coding:utf-8 -*-
from flask import Flask, request, render_template, redirect, url_for, abort, flash

app = Flask(__name__)
app.secret_key = 'une cle(token) : grain de sel(any random string)'

########################################################### Sujet 8

auteurs=[
    {'id':1,'nomAuteur':'Goscinny-Uderzo'},
    {'id':2,'nomAuteur':'Roba-Rosy'},
    {'id':3,'nomAuteur':'Herge'},
    {'id':4,'nomAuteur':'Franquin - Delporte'}
]
bandesDessinees=[
    {'id':1,'serieBD':'Astérix et Obélix', 'auteur_id':1, 'titre':'La serpe d or', 'tome':1, 'dateParution':'2005-10-09', 'prix':'7.5', 'image':'bd1.jpg'},
    {'id':2,'serieBD':'Astérix et Obélix', 'auteur_id':1, 'titre':'Asterix et les Goths', 'tome':'2', 'dateParution': '2011-10-10', 'prix':'10', 'image':'bd2.jpg'},
    {'id':3,'serieBD':'Astérix et Obélix', 'auteur_id':1, 'titre':'Asterix et les gladiateurs', 'tome':'3', 'dateParution': '2004-10-11', 'prix':'5', 'image':'bd3.jpg'},
    {'id':4,'serieBD':'Astérix et Obélix', 'auteur_id':1, 'titre':'Tour de Gaule d astérix', 'tome':'4', 'dateParution': '2005-09-10', 'prix':'8.5', 'image':'bd20.jpg'},
    {'id':5,'serieBD':'Astérix et Obélix', 'auteur_id':1, 'titre':'La zizanie', 'tome':'15', 'dateParution': '2014-09-10', 'prix':'15', 'image':'bd4.jpg'},
    {'id':6,'serieBD':'Boule et Bill', 'auteur_id':2, 'titre':'60 gags de Boule et Bill', 'tome':1, 'dateParution':'2010-10-11', 'prix':'10', 'image':'bd5.jpg'},
    {'id':7,'serieBD':'Boule et Bill', 'auteur_id':2, 'titre':'Papa maman, Boule et... moi', 'tome':'8', 'dateParution':'2005-10-11', 'prix':'10.5', 'image':'bd6.jpg'},
    {'id':8,'serieBD':'Boule et Bill', 'auteur_id':2, 'titre':'Une vie de chien !', 'tome':'9', 'dateParution':'2012-10-11', 'prix':'20', 'image':'bd7.jpg'},
    {'id':9,'serieBD':'Boule et Bill', 'auteur_id':2, 'titre':'Attention chien marrant !', 'tome':'10', 'dateParution':'2013-10-11', 'prix':'10', 'image':'bd8.jpg'},
    {'id':10,'serieBD':'Boule et Bill', 'auteur_id':2, 'titre':'Jeux de Bill', 'tome':'11', 'dateParution':'2014-10-11', 'prix':'20', 'image':'bd9.jpg'},
    {'id':11,'serieBD':'Tintin', 'auteur_id':3, 'titre':'Tintin au pays des Soviets', 'tome':'1', 'dateParution':'2005-10-11', 'prix':'10', 'image':'bd10.jpg'},
    {'id':12,'serieBD':'Tintin', 'auteur_id':3, 'titre':'Tintin au Congo', 'tome':'2', 'dateParution':'2011-07-11', 'prix':'10', 'image':'bd11.jpg'},
    {'id':13,'serieBD':'Tintin', 'auteur_id':3, 'titre':'Tintin en Amérique', 'tome':'3', 'dateParution':'2012-10-11', 'prix':'10', 'image':'bd12.jpg'},
    {'id':14,'serieBD':'Tintin', 'auteur_id':3, 'titre':'Les Cigares du pharaon', 'tome':'4', 'dateParution':'2005-10-13', 'prix':'20', 'image':'bd13.jpg'},
    {'id':15,'serieBD':'Tintin', 'auteur_id':3, 'titre':'Le lotus bleu', 'tome':'5', 'dateParution':'2014-10-13', 'prix':'20', 'image':'bd14.jpg'},
    {'id':16,'serieBD':'Gaston Lagaffe', 'auteur_id':4, 'titre':'Gare aux gaffes', 'tome':1, 'dateParution':'2010-12-03', 'prix':'10', 'image':'bd15.jpg'},
    {'id':17,'serieBD':'Gaston Lagaffe', 'auteur_id':4, 'titre':'Gala de gaffes', 'tome':'2', 'dateParution':'2012-09-06', 'prix':'10', 'image':'bd16.jpg'},
    {'id':18,'serieBD':'Gaston Lagaffe', 'auteur_id':4, 'titre':'Gaffes à gogo', 'tome':'3', 'dateParution':'2014-08-06', 'prix':'8', 'image':'bd17.jpg'},
    {'id':19,'serieBD':'Gaston Lagaffe', 'auteur_id':4, 'titre':'Gaffes en gros', 'tome':'4', 'dateParution':'2013-04-06', 'prix':'10', 'image':'bd18.jpg'},
    {'id':20,'serieBD':'Gaston Lagaffe', 'auteur_id':4, 'titre':'Les gaffes d un gars gonflé', 'tome':'5', 'dateParution':'2005-03-06', 'prix':'8', 'image':None}
]

@app.route('/')
def show_accueil():
    return render_template('layout.html')

###########################################
## AUTEURS ################################
###########################################
@app.route('/auteur/show')
def show_auteur():
    #print(auteurs)
    return render_template('auteur/show_auteur.html', auteurs=auteurs)

@app.route('/auteur/add', methods=['GET'])
def add_auteur():
    return render_template('auteur/add_auteur.html')

#Traitement des données du formulaire Add Auteur
@app.route('/auteur/add', methods=['POST'])
def valid_add_auteur():
    nomAuteur = request.form.get('nomAuteur', '')
    print('Auteur ajouté ! | nomAuteur:',nomAuteur)
    message = 'Auteur ajouté ! | nomAuteur:'+nomAuteur
    flash(message, 'alert-success')
    return redirect('/auteur/show')

#Suppression d'un auteur
@app.route('/auteur/delete', methods=['GET'])
def delete_auteur():
    id = request.args.get('id', '')
    print ("Un auteur supprimé ! | id:",id)
    message='Un auteur supprimé ! | id:'+id
    flash(message, 'alert-warning')
    return redirect('/auteur/show')

# traiter les paramètres du lien et afficher le formulaire avec les données de la ligne sélectionnée
@app.route('/auteur/edit', methods=['GET'])
def edit_auteur():
    id = request.args.get('id', '')
    nomAuteur = request.args.get('nomAuteur', '')     # comment passé plusieurs paramètres (clé primaire composés)
    id=int(id)
    auteur = auteurs[id-1]
    return render_template('auteur/edit_auteur.html', auteur=auteur)

# Traite les données du formulaire comme pour ajouter un enregistrement dans une table.
@app.route('/auteur/edit', methods=['POST'])
def valid_edit_auteur():
    nomAuteur = request.form['nomAuteur']
    id = request.form.get('id', '')
    print('Auteur modifié ! | id:',id, "| nomAuteur:",nomAuteur)
    message='Auteur modifié ! | id:'+id+ "| nomAuteur:"+nomAuteur
    flash(message, 'alert-success')
    return redirect('/auteur/show')


###########################################
## BD #####################################
###########################################
@app.route('/bande-dessinee/show')
def show_bande_dessinee():
    # print(bandesDessinees)
    return render_template('bande-dessinee/show_bande_dessinee.html', bandesDessinees=bandesDessinees)

#Add BD
@app.route('/bande-dessinee/add', methods=['GET'])
def add_bande_dessinee():
    return render_template('bande-dessinee/add_bande_dessinee.html', auteurs=auteurs)

@app.route('/bande-dessinee/add', methods=['POST'])
def valid_add_bande_dessinee():
    serieBD = request.form.get('serieBD', '')
    auteur_id = request.form.get('auteur_id', '')
    titre = request.form.get('titre', '')
    tome = request.form.get('tome', '')
    dateParution = request.form.get('dateParution', '')
    prix = request.form.get('prix', '')
    image = request.form.get('image', '')
    print('BD ajoutée ! | serieBD:',serieBD,'| auteur_id:',auteur_id,'| titre:',titre,'| tome:',tome,'| dateParution:',dateParution,'| prix:',prix,'| image:',image)
    message = 'BD ajoutée ! | serieBD:'+serieBD+'| auteur_id:'+auteur_id+'| titre:'+titre+'| tome:'+tome+'| dateParution:'+dateParution+'| prix:'+prix+'| image:'+image
    flash(message, 'alert-success')
    return redirect('/bande-dessinee/show')

#Delete BD
@app.route('/bande-dessinee/delete', methods=['GET'])
def delete_bande_dessinee():
    id = request.args.get('id', '')
    message='Une BD supprimée ! | id:'+id
    flash(message, 'alert-warning')
    return redirect('/bande-dessinee/show')

#Edit BD
@app.route('/bande-dessinee/edit', methods=['GET'])
def edit_bande_dessinee():
    id = request.args.get('id', '')
    id=int(id)
    bandeDessinee = bandesDessinees[id-1]
    return render_template('bande-dessinee/edit_bande_dessinee.html', bandeDessinee=bandeDessinee, auteurs=auteurs)

@app.route('/bande-dessinee/edit', methods=['POST'])
def valid_edit_bande_dessinee():
    id = request.form.get('id', '')
    serieBD = request.form.get('serieBD', '')
    auteur_id = request.form.get('auteur_id')
    titre = request.form.get('titre', '')
    tome = request.form.get('tome', '')
    dateParution = request.form.get('dateParution', '')
    prix = request.form.get('prix', '')
    image = request.form.get('image', '')
    print('BD modifiée ! | serieBD:', serieBD, '| auteur_id:', auteur_id, '| titre:', titre, '| tome:', tome,'| dateParution:', dateParution, '| prix:', prix, '| image:', image)
    message = 'BD modifiée ! | serieBD:' + serieBD + '| auteur_id:' + auteur_id + '| titre:' + titre + '| tome:' + tome + '| dateParution:' + dateParution + '| prix:' + prix + '| image:' + image
    flash(message, 'alert-success')
    return redirect('/bande-dessinee/show')

###########################################
## CARDS ##################################
###########################################

@app.route('/bande-dessinee/filtre')
def filtre_bande_dessinee():
    #print(auteurs)
    return render_template('bande-dessinee/front_bande_dessinee_filtre_show.html', auteurs=auteurs, bandesDessinees=bandesDessinees)

if __name__ == '__main__':
    app.run()
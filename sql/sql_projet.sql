DROP TABLE IF EXISTS consommation;
DROP TABLE IF EXISTS signatures;
DROP TABLE IF EXISTS contrat;
DROP TABLE IF EXISTS locataire;
DROP TABLE IF EXISTS appartement;
DROP TABLE IF EXISTS typeAppartement;
DROP TABLE IF EXISTS batiment;

CREATE TABLE batiment(
   num_batiment INT AUTO_INCREMENT,
   nb_etage INT NOT NULL,
   PRIMARY KEY(num_batiment)
);

CREATE TABLE typeAppartement(
   id_type_appart INT AUTO_INCREMENT,
   libelle_type_appart VARCHAR(50),
   PRIMARY KEY(id_type_appart)
);

CREATE TABLE appartement(
   num_appartement INT AUTO_INCREMENT,
   superficie_appartement INT NOT NULL,
   etage_appartement INT NOT NULL,
   id_type_appart INT NOT NULL,
   num_batiment INT NOT NULL,
   PRIMARY KEY(num_appartement),
   FOREIGN KEY(id_type_appart) REFERENCES typeAppartement(id_type_appart),
   FOREIGN KEY(num_batiment) REFERENCES batiment(num_batiment)
);

CREATE TABLE locataire(
   id_locataire INT AUTO_INCREMENT,
   prenom_locataire VARCHAR(50),
   nom_locataire VARCHAR(20),
   telephone_locataire VARCHAR(15),
   mail_locataire VARCHAR(100),
   num_appartement INT NOT NULL,
   PRIMARY KEY(id_locataire),
   FOREIGN KEY(num_appartement) REFERENCES appartement(num_appartement)
);

CREATE TABLE contrat(
   id_contrat INT AUTO_INCREMENT,
   montant_loyer DECIMAL(6,2),
   date_signature DATE NOT NULL,
   date_debut_contrat DATE NOT NULL ,
   date_fin_contrat DATE NOT NULL ,
   nb_locataires INT NOT NULL,
   num_appartement INT NOT NULL,
   PRIMARY KEY(id_contrat),
   FOREIGN KEY(num_appartement) REFERENCES appartement(num_appartement)
);

CREATE TABLE signatures(
   id_locataire INT,
   id_contrat INT,
   PRIMARY KEY(id_locataire, id_contrat),
   FOREIGN KEY(id_locataire) REFERENCES locataire(id_locataire),
   FOREIGN KEY(id_contrat) REFERENCES contrat(id_contrat)
);

CREATE TABLE consommation(
   num_appartement INT,
   date_conso DATE,
   conso_eau_mois INT,
   dechets_mois INT,
   conso_elec_mois INT,
   PRIMARY KEY(num_appartement, date_conso),
   FOREIGN KEY(num_appartement) REFERENCES appartement(num_appartement)
);

INSERT INTO batiment VALUES (NULL,3);
INSERT INTO batiment VALUES (NULL,4);
INSERT INTO batiment VALUES (NULL,3);
INSERT INTO typeAppartement VALUES (NULL,'T1');
INSERT INTO typeAppartement VALUES (NULL,'T2');
INSERT INTO typeAppartement VALUES (NULL,'T3');
INSERT INTO typeAppartement VALUES (NULL,'T4');
INSERT INTO appartement VALUES (NULL,20,1,1,1);
INSERT INTO appartement VALUES (NULL,40,2,2,1);
INSERT INTO appartement VALUES (NULL,60,1,3,3);
INSERT INTO appartement VALUES (NULL,80,1,4,2);
INSERT INTO locataire VALUES (NULL,'David K.','Babcock','05.47.01.73.35', 'DavidK.Babcock@yahoo.fr',1);
INSERT INTO locataire VALUES (NULL,'Bahirah Rahimah','Maalouf','04.27.30.95.13', 'BahirahRahimahMaalouf@jourrapide.com',2);
INSERT INTO locataire VALUES (NULL,'Duenna','Took-Brandybuck','01.75.95.05.21', 'DuennaTook-Brandybuck@armyspy.com',3);
INSERT INTO locataire VALUES (NULL,'Chinweike','Kenechukwu','03.21.21.53.68', 'ChinweikeKenechukwu@teleworm.us',4);
INSERT INTO contrat VALUES (NULL, 500.00, '2016-01-10', '2016-01-20', '2024-03-15', 1, 1);
INSERT INTO contrat VALUES (NULL, 700.00, '2017-02-10', '2017-01-20', '2024-04-20', 1, 2);
INSERT INTO contrat VALUES (NULL, 850.00, '2018-03-10', '2018-01-20', '2024-05-25', 1, 3);
INSERT INTO contrat VALUES (NULL, 1050.00, '2019-04-10', '2019-01-20', '2024-06-30', 1, 4);
INSERT INTO signatures VALUES (1,1);
INSERT INTO signatures VALUES (2,2);
INSERT INTO signatures VALUES (3,3);
INSERT INTO signatures VALUES (4,4);
INSERT INTO consommation VALUES (1,'2017-12-31', 5, 25, 150);
INSERT INTO consommation VALUES (1,'2018-01-31', 10, 30, 200);
INSERT INTO consommation VALUES (1,'2018-02-28', 7, 20, 250);
INSERT INTO consommation VALUES (1,'2018-03-31', 8, 15, 270);
INSERT INTO consommation VALUES (2,'2017-12-31', 6, 22, 120);
INSERT INTO consommation VALUES (2,'2018-01-31', 10, 30, 150);
INSERT INTO consommation VALUES (2,'2018-02-28', 7, 22, 200);
INSERT INTO consommation VALUES (2,'2018-03-31', 9, 15, 220);
INSERT INTO consommation VALUES (3,'2018-12-31', 5, 25, 120);
INSERT INTO consommation VALUES (3,'2019-01-31', 8, 30, 125);
INSERT INTO consommation VALUES (3,'2019-02-28', 7, 20, 170);
INSERT INTO consommation VALUES (3,'2019-03-31', 5, 12, 150);
INSERT INTO consommation VALUES (4,'2019-12-31', 5, 25, 120);
INSERT INTO consommation VALUES (4,'2020-01-31', 8, 22, 135);
INSERT INTO consommation VALUES (4,'2020-02-29', 7, 18, 160);
INSERT INTO consommation VALUES (4,'2020-03-31', 5, 15, 125);

SELECT COUNT(appartement.num_appartement) as conso_elec_en_dessous_de_200 , appartement.num_appartement as appartement_n°
FROM appartement
INNER JOIN consommation on appartement.num_appartement = consommation.num_appartement
WHERE conso_elec_mois < 200
GROUP BY appartement.num_appartement;

SELECT ROUND(AVG(montant_loyer),2) as loyer_moyen
FROM contrat;

SELECT ROUND(AVG(conso_eau_mois),2) as conso_eau_moyenne,
        ROUND(AVG(dechets_mois),2) as dechets_moyen,
        ROUND(AVG(conso_elec_mois),2) as conso_elec_moyenne,
        appartement.num_appartement as appartement_n°
FROM appartement
INNER JOIN consommation on appartement.num_appartement = consommation.num_appartement
GROUP BY appartement.num_appartement;

SELECT locataire.nom_locataire, locataire.prenom_locataire,MAX(consommation.conso_eau_mois) AS conso_eau_mois_max
FROM appartement
INNER JOIN locataire on appartement.num_appartement = locataire.num_appartement
INNER JOIN consommation on appartement.num_appartement = consommation.num_appartement
WHERE consommation.conso_eau_mois = (SELECT MAX(conso_eau_mois) FROM consommation)
GROUP BY locataire.nom_locataire, locataire.prenom_locataire;

SELECT locataire.nom_locataire, locataire.prenom_locataire,MAX(consommation.conso_elec_mois) AS conso_elec_mois_max
FROM appartement
INNER JOIN locataire on appartement.num_appartement = locataire.num_appartement
INNER JOIN consommation on appartement.num_appartement = consommation.num_appartement
WHERE consommation.conso_elec_mois = (SELECT MAX(conso_elec_mois) FROM consommation)
GROUP BY locataire.nom_locataire, locataire.prenom_locataire;

SELECT locataire.nom_locataire, locataire.prenom_locataire,MAX(consommation.dechets_mois) AS dechets_mois_max
FROM appartement
INNER JOIN locataire on appartement.num_appartement = locataire.num_appartement
INNER JOIN consommation on appartement.num_appartement = consommation.num_appartement
WHERE consommation.dechets_mois = (SELECT MAX(dechets_mois) FROM consommation)
GROUP BY locataire.nom_locataire, locataire.prenom_locataire;

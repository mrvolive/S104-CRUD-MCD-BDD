DROP TABLE IF EXISTS consomme;
DROP TABLE IF EXISTS signatures;
DROP TABLE IF EXISTS contrat;
DROP TABLE IF EXISTS locataire;
DROP TABLE IF EXISTS appartement;
DROP TABLE IF EXISTS typeAppartement;
DROP TABLE IF EXISTS batiment;
DROP TABLE IF EXISTS consommable;

CREATE TABLE consommable(
   id_consommable INT AUTO_INCREMENT,
   libelle_consommable VARCHAR(50),
   PRIMARY KEY(id_consommable)
);

CREATE TABLE batiment(
   num_batiment INT AUTO_INCREMENT,
   nb_etage INT,
   PRIMARY KEY(num_batiment)
);

CREATE TABLE typeAppartement(
   id_type_appart INT AUTO_INCREMENT,
   libelle_type_appart VARCHAR(50),
   PRIMARY KEY(id_type_appart)
);

CREATE TABLE appartement(
   num_appartement INT AUTO_INCREMENT,
   superficie_appartement INT,
   etage_appartement INT,
   id_type_appart INT NOT NULL,
   num_batiment INT NOT NULL,
   PRIMARY KEY(num_appartement),
   FOREIGN KEY(id_type_appart) REFERENCES typeAppartement(id_type_appart),
   FOREIGN KEY(num_batiment) REFERENCES batiment(num_batiment)
);

CREATE TABLE locataire(
   id_locataire INT AUTO_INCREMENT,
   prenom_locataire VARCHAR(50),
   nom_locataire VARCHAR(50),
   telephone_locataire VARCHAR(15),
   age_locataire INT,
   mail_locataire VARCHAR(100),
   num_appartement INT NOT NULL,
   PRIMARY KEY(id_locataire),
   FOREIGN KEY(num_appartement) REFERENCES appartement(num_appartement)
);

CREATE TABLE contrat(
   id_contrat INT AUTO_INCREMENT,
   montant_loyer DECIMAL(6,2),
   date_signature DATE,
   date_debut_contrat DATE,
   date_fin_contrat DATE,
   nb_locataires INT,
   num_appartement INT NOT NULL,
   PRIMARY KEY(id_contrat),
   FOREIGN KEY(num_appartement) REFERENCES appartement(num_appartement)
);

CREATE TABLE signatures(
   id_locataire INT NOT NULL,
   id_contrat INT NOT NULL,
   PRIMARY KEY(id_locataire, id_contrat),
   FOREIGN KEY(id_locataire) REFERENCES locataire(id_locataire),
   FOREIGN KEY(id_contrat) REFERENCES contrat(id_contrat)
);

CREATE TABLE consomme(
   id_consomme INT AUTO_INCREMENT,
   date_conso DATE,
   quantite_consomme INT,
   id_consommable INT NOT NULL,
   num_appartement INT,
   PRIMARY KEY(id_consomme),
   FOREIGN KEY(num_appartement) REFERENCES appartement(num_appartement),
   FOREIGN KEY(id_consommable) REFERENCES consommable(id_consommable)
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
INSERT INTO locataire VALUES (NULL,'David K.','Babcock','0547017335','56', 'DavidK.Babcock@yahoo.fr',1);
INSERT INTO locataire VALUES (NULL,'Bahirah Rahimah','Maalouf','0427309513','65', 'BahirahRahimahMaalouf@jourrapide.com',2);
INSERT INTO locataire VALUES (NULL,'Duenna','Took-Brandybuck','0175950521','40', 'DuennaTook-Brandybuck@armyspy.com',3);
INSERT INTO locataire VALUES (NULL,'Chinweike','Kenechukwu','0321153682','53', 'ChinweikeKenechukwu@teleworm.us',4);
INSERT INTO contrat VALUES (NULL, 500.00, '2016-01-10', '2016-01-20', '2024-03-15', 1, 1);
INSERT INTO contrat VALUES (NULL, 700.00, '2017-02-10', '2017-01-20', '2024-04-20', 1, 2);
INSERT INTO contrat VALUES (NULL, 850.00, '2018-03-10', '2018-01-20', '2024-05-25', 1, 3);
INSERT INTO contrat VALUES (NULL, 1050.00, '2019-04-10', '2019-01-20', '2024-06-30', 1, 4);
INSERT INTO signatures VALUES (1,1);
INSERT INTO signatures VALUES (2,2);
INSERT INTO signatures VALUES (3,3);
INSERT INTO signatures VALUES (4,4);
INSERT INTO consommable VALUES (NULL,'Eau en L');
INSERT INTO consommable VALUES (NULL,'Electricité en kWh');
INSERT INTO consommable VALUES (NULL,'Déchets en kg');
-- Consommation d'eau en L
INSERT INTO consomme VALUES (NULL,'2017-12-31', 4234, 1, 1);
INSERT INTO consomme VALUES (NULL,'2018-01-31', 4435, 1, 1);
INSERT INTO consomme VALUES (NULL,'2018-02-28', 4498, 1, 1);
INSERT INTO consomme VALUES (NULL,'2018-03-31', 4534, 1, 1);
INSERT INTO consomme VALUES (NULL,'2017-12-31', 4980, 1, 2);
INSERT INTO consomme VALUES (NULL,'2018-01-31', 4239, 1, 2);
INSERT INTO consomme VALUES (NULL,'2018-02-28', 4890, 1, 2);
INSERT INTO consomme VALUES (NULL,'2018-03-31', 4098, 1, 2);
INSERT INTO consomme VALUES (NULL,'2018-12-31', 4921, 1, 3);
INSERT INTO consomme VALUES (NULL,'2019-01-31', 4923, 1, 3);
INSERT INTO consomme VALUES (NULL,'2019-02-28', 4653, 1, 3);
INSERT INTO consomme VALUES (NULL,'2019-03-31', 5203, 1, 3);
INSERT INTO consomme VALUES (NULL,'2019-12-31', 4563, 1, 4);
INSERT INTO consomme VALUES (NULL,'2020-01-31', 4278, 1, 4);
INSERT INTO consomme VALUES (NULL,'2020-02-29', 5023, 1, 4);
INSERT INTO consomme VALUES (NULL,'2020-03-31', 4672, 1, 4);
-- Consommation d'électricité en kWh
INSERT INTO consomme VALUES (NULL,'2017-12-31', 292, 2, 1);
INSERT INTO consomme VALUES (NULL,'2018-01-31', 245, 2, 1);
INSERT INTO consomme VALUES (NULL,'2018-02-28', 327, 2, 1);
INSERT INTO consomme VALUES (NULL,'2018-03-31', 245, 2, 1);
INSERT INTO consomme VALUES (NULL,'2017-12-31', 335, 2, 2);
INSERT INTO consomme VALUES (NULL,'2018-01-31', 265, 2, 2);
INSERT INTO consomme VALUES (NULL,'2018-02-28', 312, 2, 2);
INSERT INTO consomme VALUES (NULL,'2018-03-31', 332, 2, 2);
INSERT INTO consomme VALUES (NULL,'2018-12-31', 277, 2, 3);
INSERT INTO consomme VALUES (NULL,'2019-01-31', 267, 2, 3);
INSERT INTO consomme VALUES (NULL,'2019-02-28', 248, 2, 3);
INSERT INTO consomme VALUES (NULL,'2019-03-31', 305, 2, 3);
INSERT INTO consomme VALUES (NULL,'2019-12-31', 265, 2, 4);
INSERT INTO consomme VALUES (NULL,'2020-01-31', 278, 2, 4);
INSERT INTO consomme VALUES (NULL,'2020-02-29', 319, 2, 4);
INSERT INTO consomme VALUES (NULL,'2020-03-31', 278, 2, 4);
-- Production de déchets en kg
INSERT INTO consomme VALUES (NULL,'2017-12-31', 35, 3, 1);
INSERT INTO consomme VALUES (NULL,'2018-01-31', 42, 3, 1);
INSERT INTO consomme VALUES (NULL,'2018-02-28', 33, 3, 1);
INSERT INTO consomme VALUES (NULL,'2018-03-31', 25, 3, 1);
INSERT INTO consomme VALUES (NULL,'2017-12-31', 32, 3, 2);
INSERT INTO consomme VALUES (NULL,'2018-01-31', 47, 3, 2);
INSERT INTO consomme VALUES (NULL,'2018-02-28', 32, 3, 2);
INSERT INTO consomme VALUES (NULL,'2018-03-31', 25, 3, 2);
INSERT INTO consomme VALUES (NULL,'2018-12-31', 35, 3, 3);
INSERT INTO consomme VALUES (NULL,'2019-01-31', 41, 3, 3);
INSERT INTO consomme VALUES (NULL,'2019-02-28', 36, 3, 3);
INSERT INTO consomme VALUES (NULL,'2019-03-31', 23, 3, 3);
INSERT INTO consomme VALUES (NULL,'2019-12-31', 35, 3, 4);
INSERT INTO consomme VALUES (NULL,'2020-01-31', 32, 3, 4);
INSERT INTO consomme VALUES (NULL,'2020-02-29', 28, 3, 4);
INSERT INTO consomme VALUES (NULL,'2020-03-31', 25, 3, 4);


SELECT COUNT(appartement.num_appartement) as 'Consommation Electrique > 300 kWh/mois' , appartement.num_appartement as 'Numéro d\'appartement'
FROM consomme
INNER JOIN appartement on consomme.num_appartement = appartement.num_appartement
WHERE consomme.id_consommable = 2 AND consomme.quantite_consomme > 300
GROUP BY appartement.num_appartement;

SELECT ROUND(AVG(montant_loyer),2) as 'Loyer Moyen en €/mois'
FROM contrat;

SELECT ROUND(AVG(quantite_consomme),2) as conso_eau_moyenne,
        appartement.num_appartement as appartement_n°
FROM consomme
INNER JOIN appartement on consomme.num_appartement = appartement.num_appartement
WHERE consomme.id_consommable = 1
GROUP BY appartement.num_appartement;

SELECT ROUND(AVG(quantite_consomme),2) as conso_elec_moyenne,
        appartement.num_appartement as appartement_n°
FROM consomme
INNER JOIN appartement on consomme.num_appartement = appartement.num_appartement
WHERE consomme.id_consommable = 2
GROUP BY appartement.num_appartement;

SELECT  ROUND(AVG(quantite_consomme),2) as dechets_moyen,
        appartement.num_appartement as appartement_n°
FROM consomme
INNER JOIN appartement on consomme.num_appartement = appartement.num_appartement
WHERE consomme.id_consommable = 3
GROUP BY appartement.num_appartement;


SELECT locataire.nom_locataire, locataire.prenom_locataire,appartement.num_appartement AS 'Numéro d\'appartement',MAX(consomme.quantite_consomme) AS conso_eau_mois_max
FROM appartement
INNER JOIN locataire on appartement.num_appartement = locataire.num_appartement
INNER JOIN consomme on appartement.num_appartement = consomme.num_appartement
WHERE consomme.quantite_consomme = (SELECT MAX(quantite_consomme) FROM consomme WHERE id_consommable = 1) AND consomme.id_consommable = 1
GROUP BY locataire.nom_locataire, locataire.prenom_locataire;

SELECT locataire.nom_locataire, locataire.prenom_locataire,appartement.num_appartement AS 'Numéro d\'appartement',MAX(consomme.quantite_consomme) AS conso_elec_mois_max
FROM appartement
INNER JOIN locataire on appartement.num_appartement = locataire.num_appartement
INNER JOIN consomme on appartement.num_appartement = consomme.num_appartement
WHERE consomme.quantite_consomme = (SELECT MAX(quantite_consomme) FROM consomme WHERE id_consommable = 2) AND consomme.id_consommable = 2
GROUP BY locataire.nom_locataire, locataire.prenom_locataire;

SELECT locataire.nom_locataire, locataire.prenom_locataire,appartement.num_appartement AS 'Numéro d\'appartement',MAX(consomme.quantite_consomme) AS dechets_mois_max
FROM appartement
INNER JOIN locataire on appartement.num_appartement = locataire.num_appartement
INNER JOIN consomme on appartement.num_appartement = consomme.num_appartement
WHERE consomme.quantite_consomme = (SELECT MAX(quantite_consomme) FROM consomme)
GROUP BY locataire.nom_locataire, locataire.prenom_locataire;

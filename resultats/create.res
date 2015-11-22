CREATE TABLE Employe
(CodeEmploye VARCHAR(3) PRIMARY KEY,
NAS int NOT NULL,
Nom VARCHAR(30) NOT NULL,
Prenom VARCHAR(30) NOT NULL,
NomJeuneFille VARCHAR(30),
DateNaissance DATE NOT NULL,
Adresse VARCHAR(100) NOT NULL,
Telephone VARCHAR(12) NOT NULL,
Fonction VARCHAR(30) NOT NULL,
Service VARCHAR(30) NOT NULL,
Taux int,
Grade int));

CREATE TABLE Salaire
(CodeEmploye VARCHAR(3),
Mois int,
Salaire int,
PRIMARY KEY (CodeEmploye, Mois),
FOREIGN KEY CodeEmploye REFERENCING Employe(CodeEmploye));

CREATE TABLE Zone
(CodeZone int PRIMARY KEY,
NomZone VARCHAR(30) NOT NULL,
ChefZone VARCHAR(3) NOT NULL,
FOREIGN KEY ChefZone REFERENCING Employe(CodeEmploye));

CREATE TABLE Lotissement
(CodeZone int,
CodeLotissement int,
NomLotissement VARCHAR(30) NOT NULL,
PRIMARY KEY (CodeZone, CodeLotissement),
FOREIGN KEY CodeZone REFERENCING Zone (CodeZone));

CREATE TABLE Surveillance
(CodeEmploye VARCHAR(3),
CodeZone int,
CodeLotissement int,
Jour int,
Heure int,
PRIMARY KEY (CodeEmploye, CodeZone, CodeLotissement),
FOREIGN KEY CodeEmploye REFERENCING Employe(CodeEmploye),
FOREIGN KEY CodeZone REFERENCING Zone(CodeZone),
FOREIGN KEY CodeLotissement REFERENCING Lotissement(CodeLotissement));

CREATE TABLE Choix
(CodeEmploye VARCHAR(3),
CodeZone int,
Affinite int NOT NULL,
PRIMARY KEY (CodeEmploye, CodeZone),
FOREIGN KEY CodeEmploye REFERENCING Employe(CodeEmploye),
FOREIGN KEY CodeZone REFERENCING Zone(CodeZone));

CREATE TABLE Espece
(CodeEspece int PRIMARY KEY,
NomEspece VARCHAR(30) NOT NULL,
Nombre int,
CodeZone int,
CodeLotissement int,
FOREIGN KEY CodeZone REFERENCING Zone(CodeZone)
FOREIGN KEY CodeLotissement REFERENCING Lotissement(CodeLotissement));

CREATE TABLE Individu
(CodeIndividu int PRIMARY KEY,
NomIndividu VARCHAR(30) NOT NULL,
CodeEspece int,
Sang VARCHAR(2) NOT NULL,
DateNaissance DATE NOT NULL,
DateDeces DATE,
Pere int,
Mere int,
FOREIGN KEY CodeEspece REFERENCING Espece(CodeEspece),
FOREIGN KEY Pere REFERENCING Individu(CodeIndividu),
FOREIGN KEY Mere REFERENCING Individu(CodeIndividu));

CREATE TABLE Mesure
(CodeIndividu int,
DateMesure DATE,
Poids int NOT NULL,
Taille int NOT NULL,
PRIMARY KEY (CodeIndividu, DateMesure),
FOREIGN KEY CodeIndividu REFERENCING Individu(CodeIndividu));
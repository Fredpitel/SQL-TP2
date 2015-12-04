--
-- Script de creation des tables
-- Frédéric Pitel;, Keven Blais
-- Code permanent: PITF16088608
-- Code permanent: BLAK29019305
-- 
SET ECHO ON

SPOOL create.res
/
CREATE TABLE Employe
(
CodeEmploye VARCHAR(3) PRIMARY KEY,
NAS VARCHAR(9) UNIQUE NOT NULL CHECK (LENGTH(NAS) = 9),
Nom VARCHAR(30) NOT NULL,
Prenom VARCHAR(30) NOT NULL,
NomJeuneFille VARCHAR(30),
DateNaissance DATE NOT NULL,
Adresse VARCHAR(100) NOT NULL,
Telephone VARCHAR(12) NOT NULL,
Fonction VARCHAR(30) NOT NULL CHECK (Fonction IN ('V�t�rinaire', 'Infirmi�re', 'Surveillant', 'Chef de zone', 'Secr�taire', 'Comptable', 'Chef du personnel', 'Directeur')),
Service VARCHAR(30) NOT NULL CHECK (Service IN ('M�dical', 'Surveillance', 'Administratif')),
Taux INTEGER CHECK (Taux > 0),
Grade VARCHAR(2) CHECK (Grade IN ('G1', 'G2', 'G3', 'G4', 'G5'))
)
/
CREATE TABLE Salaire
(
CodeEmploye VARCHAR(3),
Mois INTEGER CHECK (Mois > 0 AND Mois <= 12),
Salaire INTEGER NOT NULL CHECK (Salaire >= 0),
PRIMARY KEY (CodeEmploye, Mois),
FOREIGN KEY (CodeEmploye) REFERENCES Employe (CodeEmploye)
)
/
CREATE TABLE Zones
(
CodeZone INTEGER PRIMARY KEY CHECK (CodeZone > 0),
NomZone VARCHAR(30) NOT NULL,
ChefZone VARCHAR(3) NOT NULL,
FOREIGN KEY (ChefZone) REFERENCES Employe(CodeEmploye)
)
/
CREATE TABLE Lotissement
(
CodeZone INTEGER,
CodeLotissement INTEGER CHECK (CodeLotissement > 0),
NomLotissement VARCHAR(30) NOT NULL,
PRIMARY KEY (CodeZone, CodeLotissement),
FOREIGN KEY (CodeZone) REFERENCES Zones(CodeZone)
)
/
CREATE TABLE Surveillance
(
CodeEmploye VARCHAR(3),
CodeZone INTEGER,
CodeLotissement INTEGER,
Jour VARCHAR(8) NOT NULL CHECK (Jour IN ('Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche')),
Heure INTEGER NOT NULL CHECK (HEURE >= 9 AND HEURE <= 17),
PRIMARY KEY (CodeEmploye, CodeZone, CodeLotissement),
FOREIGN KEY (CodeEmploye) REFERENCES Employe(CodeEmploye),
FOREIGN KEY (CodeZone,CodeLotissement) REFERENCES Lotissement(CodeZone ,CodeLotissement)
)
/
CREATE TABLE Choix
(
CodeEmploye VARCHAR(3),
CodeZone INTEGER,
Affinite INTEGER NOT NULL CHECK (Affinite IN('0', '1')),
PRIMARY KEY (CodeEmploye, CodeZone),
FOREIGN KEY (CodeEmploye) REFERENCES Employe(CodeEmploye),
FOREIGN KEY (CodeZone) REFERENCES Zones(CodeZone)
)
/
CREATE TABLE Espece
(
CodeEspece INTEGER PRIMARY KEY CHECK (CodeEspece > 0),
NomEspece VARCHAR(30) NOT NULL,
Nombre INTEGER CHECK (Nombre > 0),
CodeZone INTEGER,
CodeLotissement INTEGER,
FOREIGN KEY (CodeZone,CodeLotissement) REFERENCES Lotissement(CodeZone ,CodeLotissement),
CONSTRAINT nomEspeceUnique UNIQUE(nomEspece)
)
/
CREATE TABLE Individu
(
CodeIndividu INTEGER PRIMARY KEY CHECK (CodeIndividu > 0),
NomIndividu VARCHAR(30) NOT NULL,
CodeEspece INTEGER,
Sang VARCHAR(3) NOT NULL CHECK (Sang IN ('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')),
DateNaissance DATE NOT NULL,
DateDeces DATE,
Pere INTEGER,
Mere INTEGER,
FOREIGN KEY (CodeEspece) REFERENCES Espece(CodeEspece),
FOREIGN KEY (Pere) REFERENCES Individu(CodeIndividu),
FOREIGN KEY (Mere) REFERENCES Individu(CodeIndividu),
CONSTRAINT DateCoherente CHECK(DateDeces >= DateNaissance)
)
/
CREATE TABLE Mesure
(
CodeIndividu INTEGER,
DateMesure DATE DEFAULT SYSDATE NOT NULL ,
Poids INTEGER NOT NULL CHECK (Poids > 0),
Taille INTEGER NOT NULL CHECK (Taille > 0),
PRIMARY KEY (CodeIndividu, DateMesure),
FOREIGN KEY (CodeIndividu) REFERENCES Individu(CodeIndividu)
)
/

SPOOL OFF

SET ECHO OFF

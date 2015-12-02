--
-- Script de creation des tables
-- Frédéric Pitel;, Keven Blais
-- Code permanent: PITF16088608
-- Code permanent: BLAK29019305
-- 
SET ECHO ON

CREATE TABLE Employe
(
CodeEmploye VARCHAR(3) PRIMARY KEY,
NAS VARCHAR(9) NOT NULL,
Nom VARCHAR(30) NOT NULL,
Prenom VARCHAR(30) NOT NULL,
NomJeuneFille VARCHAR(30),
DateNaissance DATE NOT NULL CHECK (sysdate >= add_months(DateNaissance, 384)),
Adresse VARCHAR(100) NOT NULL,
Telephone VARCHAR(12) NOT NULL,
Fonction VARCHAR(30) NOT NULL,
Service VARCHAR(30) NOT NULL,
Taux INTEGER CHECK (Taux > 0),
Grade VARCHAR(2) CHECK (Grade IN ('G1', 'G2', 'G3', 'G4', 'G5')),
CONSTRAINT fonctionMedicaleCoherente CHECK (
NOT EXISTS (SELECT *
	    FROM Employe
	    WHERE Service = 'Médical'
	    AND (Fonction <> 'Vétérinaire' OR Fonction <> 'Infirmière')
	    )
),
CONSTRAINT fonctionSurveillanceCoherente CHECK (
NOT EXISTS (SELECT *
	    FROM Employe
	    WHERE Service = 'Surveillance'
	    AND (Fonction <> 'Surveillant' OR Fonction <> 'Chef de zone')
	    )
),
CONSTRAINT fonctionAdminCoherente CHECK (
NOT EXISTS (SELECT *
	    FROM Employe
	    WHERE Service = 'Administratif'
	    AND (Fonction <> 'Secrétaire' OR Fonction <> 'Comptable' OR Fonction <> 'Chef du personnel' OR <> 'Directeur')
	    )
)
)
/
CREATE TABLE Salaire
(
CodeEmploye VARCHAR(3),
Mois INTEGER CHECK (Mois > 0 AND Mois <= 12),
Salaire INTEGER NOT NULL CHECK (Salaire >= 0),
PRIMARY KEY (CodeEmploye, Mois),
FOREIGN KEY (CodeEmploye) REFERENCES Employe (CodeEmploye)
ON DELETE CASCADE ON UPDATE CASCADE
)
/
CREATE TABLE Zones
(
CodeZone INTEGER PRIMARY KEY CHECK (CodeZone > 0),
NomZone VARCHAR(30) NOT NULL,
ChefZone VARCHAR(3) NOT NULL,
FOREIGN KEY (ChefZone) REFERENCES Employe(CodeEmploye)
ON DELETE CASCADE ON UPDATE CASCADE
)
/
CREATE TABLE Lotissement
(
CodeZone INTEGER,
CodeLotissement INTEGER CHECK (CodeLotissement > 0),
NomLotissement VARCHAR(30) NOT NULL,
PRIMARY KEY (CodeZone, CodeLotissement),
FOREIGN KEY (CodeZone) REFERENCES Zones(CodeZone)
ON DELETE CASCADE ON UPDATE CASCADE
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
FOREIGN KEY (CodeEmploye) REFERENCES Employe(CodeEmploye)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (CodeZone,CodeLotissement) REFERENCES Lotissement(CodeZone ,CodeLotissement)
ON DELETE CASCADE ON UPDATE CASCADE
)
/
CREATE TABLE Choix
(
CodeEmploye VARCHAR(3),
CodeZone INTEGER,
Affinite INTEGER NOT NULL CHECK (Affinite IN('0', '1')),
PRIMARY KEY (CodeEmploye, CodeZone),
FOREIGN KEY (CodeEmploye) REFERENCES Employe(CodeEmploye)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (CodeZone) REFERENCES Zones(CodeZone)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT uneZoneParChoix CHECK (
NOT EXISTS (SELECT CodeEmploye, CodeZone
	    FROM Choix
	    GROUP BY CodeEmploye, CodeZone
	    HAVING COUNT(DISTINCT CodeZone) > 1)
)
)
/
CREATE TABLE Espece
(
CodeEspece INTEGER PRIMARY KEY CHECK (CodeEspece > 0),
NomEspece VARCHAR(30) NOT NULL,
Nombre INTEGER CHECK (Nombre > 0),
CodeZone INTEGER,
CodeLotissement INTEGER,
FOREIGN KEY (CodeZone,CodeLotissement) REFERENCES Lotissement(CodeZone ,CodeLotissement)
ON DELETE CASCADE ON UPDATE CASCADE,
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
DateDeces DATE CHECK (DateDeces >= DateNaissance),
Pere INTEGER,
Mere INTEGER,
FOREIGN KEY (CodeEspece) REFERENCES Espece(CodeEspece)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Pere) REFERENCES Individu(CodeIndividu)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Mere) REFERENCES Individu(CodeIndividu)
ON DELETE CASCADE ON UPDATE CASCADE
)
/
CREATE TABLE Mesure
(
CodeIndividu INTEGER,
DateMesure DATE DEFAULT sysdate NOT NULL ,
Poids INTEGER NOT NULL CHECK (Poids > 0),
Taille INTEGER NOT NULL CHECK (Taille > 0),
PRIMARY KEY (CodeIndividu, DateMesure),
FOREIGN KEY (CodeIndividu) REFERENCES Individu(CodeIndividu)
ON DELETE CASCADE ON UPDATE CASCADE
)
/
SET ECHO OFF

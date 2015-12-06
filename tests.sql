--
-- Script de test des triggers
-- Frédéric Pitel;, Keven Blais
-- Code permanent: PITF16088608
-- Code permanent: BLAK29019305
-- 
 
SET LINESIZE 160
SET ECHO ON

SPOOL tests.res;

-- Tests DateCoherente

INSERT INTO Employe VALUES ('AAA', '012345678', 'Date', 'Mauvaise', NULL, '2000-10-03', '2020 du finfin', '5142222222', 'Secrétaire', 'Administratif', NULL, NULL)
/
ROLLBACK
/
-- Tests FonctionCoherente

INSERT INTO Employe VALUES ('BBB', '123456789', 'Fonction', 'Mauvaise', NULL, '1985-10-03', '2020 du finfin', '514-222-2222', 'Surveillant', 'Administratif', '50', 'G1')
/
ROLLBACK
/

INSERT INTO Employe VALUES ('CCC', '234567890', 'Fonction', 'Mauvaise', NULL, '1985-10-03', '2020 du finfin', '514-222-2222', 'Surveillant', 'Médical', '50', 'G1')
/
ROLLBACK
/

INSERT INTO Employe VALUES ('DDD', '345678901', 'Fonction', 'Mauvaise', NULL, '1985-10-03', '2020 du finfin', '514-222-2222', 'Secrétaire', 'Surveillance', NULL, NULL)
/
ROLLBACK
/

-- Tests TauxEtGradeNonNul

INSERT INTO Employe VALUES ('EEE', '456789012', 'Grade', 'Mauvais', NULL, '1985-10-03', '2020 du finfin', '514-222-2222', 'Surveillant', 'Surveillance', 50, NULL)
/
ROLLBACK
/

INSERT INTO Employe VALUES ('FFF', '567890123', 'Taux', 'Mauvais', NULL, '1985-10-03', '2020 du finfin', '514-222-2222', 'Surveillant', 'Surveillance', NULL, 'G1')
/
ROLLBACK
/

-- Tests UneSeuleZoneParJour

INSERT INTO Surveillance VALUES ('IJH', 2, 1, 'Lundi', 12)
/
ROLLBACK
/

-- Tests LotissementParHeurePrecedent

INSERT INTO Surveillance
 	VALUES('IJH',1,	2,'Lundi',11)
/
ROLLBACK
/

-- Tests LotissementParHeureSuivant

INSERT INTO Surveillance
 	VALUES('IJH',2,	2,'Mardi',15)
/
ROLLBACK
/

-- Tests UnSeulSurveillant

INSERT INTO Surveillance
 	VALUES('JHK',1,	1,'Lundi',9)
/
ROLLBACK
/

-- Tests HeureDifferente

INSERT INTO Surveillance
 	VALUES('IJH',1,	2,'Lundi',9)
/
ROLLBACK
/



-- Tests choixSurveillant

INSERT INTO Choix
 	VALUES('JHK',1,1)
/
ROLLBACK
/

-- Tests choixAffinite

INSERT ALL
INTO Choix 	VALUES('IJH',1,1)
INTO Choix      VALUES('IJH',2,1)
INTO Choix      VALUES('IJH',3,1)
/
ROLLBACK
/

-- Tests choixLotissement

INSERT INTO Espece
    VALUES(1,'Gorille',NULL,1,2)
/
ROLLBACK
/

-- Tests consecutifLotissement

INSERT INTO Lotissement
    VALUES(2,3,'Foret')
/
ROLLBACK
/

INSERT INTO Lotissement
    VALUES(2,6,'Foret')
/
ROLLBACK
/

-- Tests excluNombre
INSERT INTO Individu
    VALUES(4,'bibi',2,'A-','1999/01/19',NULL,NULL,NULL)
/
ROLLBACK
/

-- Tests excluIndividu
UPDATE Espece
    SET Nombre = 5
    WHERE CodeEspece = 1
/
ROLLBACK
/


-- Tests excluIndividu
INSERT INTO Individu
    VALUES(4,'Bobo',3,'A-','1993/01/19',NULL,1,2)
/
ROLLBACK
/

-- Tests siPereAlorsMere
INSERT INTO Individu
    VALUES(4,'Bobo',1,'A-','1993/01/19',NULL,1,NULL)
/
ROLLBACK
/

SPOOL OFF;
SET ECHO OFF
SET PAGESIZE 30

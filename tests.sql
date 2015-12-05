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

-- Tests FonctionCoherente

INSERT INTO Employe VALUES ('BBB', '123456789', 'Fonction', 'Mauvaise', NULL, '1985-10-03', '2020 du finfin', '514-222-2222', 'Surveillant', 'Administratif', '50', 'G1')
/

INSERT INTO Employe VALUES ('CCC', '234567890', 'Fonction', 'Mauvaise', NULL, '1985-10-03', '2020 du finfin', '514-222-2222', 'Surveillant', 'Médical', '50', 'G1')
/

INSERT INTO Employe VALUES ('DDD', '345678901', 'Fonction', 'Mauvaise', NULL, '1985-10-03', '2020 du finfin', '514-222-2222', 'Secrétaire', 'Surveillance', NULL, NULL)
/

-- Tests TauxEtGradeNonNul

INSERT INTO Employe VALUES ('EEE', '456789012', 'Grade', 'Mauvais', NULL, '1985-10-03', '2020 du finfin', '514-222-2222', 'Surveillant', 'Surveillance', 50, NULL)
/

INSERT INTO Employe VALUES ('FFF', '567890123', 'Taux', 'Mauvais', NULL, '1985-10-03', '2020 du finfin', '514-222-2222', 'Surveillant', 'Surveillance', NULL, 'G1')
/

-- Tests UneSeuleZoneParJour

INSERT INTO Surveillance VALUES ('IJH', 2, 1, 'Lundi', 12)
/

-- Tests LotissementParHeurePrecedent

INSERT INTO Surveillance
 	VALUES('IJH',1,	2,'Lundi',11)
/

-- Tests LotissementParHeureSuivant

INSERT INTO Surveillance
 	VALUES('IJH',2,	2,'Mardi',15)
/

-- Tests UnSeulSurveillant

INSERT INTO Surveillance
 	VALUES('JHK',1,	1,'Lundi',9)
/

-- Tests HeureDifferente

INSERT INTO Surveillance
 	VALUES('IJH',1,	2,'Lundi',9)
/

SPOOL OFF;
SET ECHO OFF
SET PAGESIZE 30

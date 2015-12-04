--
-- Script de nettoyage
-- Frédéric Pitel;, Keven Blais
-- Code permanent: PITF16088608
-- Code permanent: BLAK29019305
-- 
SET ECHO ON

DROP TABLE Mesure;

DROP TABLE Individu;

DROP TABLE Espece;

DROP TABLE Choix;

DROP TABLE Surveillance;

DROP TABLE Lotissement;

DROP TABLE Zones;

DROP TABLE Salaire;

DROP TABLE Employe;

DROP TRIGGER DateCoherente;

DROP TRIGGER FonctionMedicaleCoherente;

DROP TRIGGER FonctionSurveillanceCoherente;

DROP TRIGGER FonctionAdministratifCoherente;

DROP TRIGGER TauxEtGradeNonNul;

DROP TRIGGER UneSeuleZoneParJour;

DROP TRIGGER LotissementParHeurePrecedent;

DROP TRIGGER LotissementParHeureSuivant;

DROP TRIGGER UnSeulSurveillant;

DROP TRIGGER LotissementsMemeZone;

DROP TRIGGER DateMesureDifferente;

SET ECHO OFF

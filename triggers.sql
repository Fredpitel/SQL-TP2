--
-- Script de creation des tables
-- Frédéric Pitel;, Keven Blais
-- Code permanent: PITF16088608
-- Code permanent: BLAK29019305
-- 
SET ECHO ON

SPOOL triggers.res;
/
CREATE TRIGGER DateCoherente
AFTER INSERT OR UPDATE ON Employe
REFERENCING NEW AS ligneApres
FOR EACH ROW
WHEN (SYSDATE < ADD_MONTHS(ligneApres.DateNaissance, 192))
BEGIN RAISE_APPLICATION_ERROR(-20000, 'L''employé n''est pas assez âgé.');
END;
/
SHOW ERR;

CREATE TRIGGER FonctionCoherente
AFTER INSERT OR UPDATE ON Employe
REFERENCING NEW AS ligneApres
FOR EACH ROW
WHEN ((ligneApres.Service = 'Médical' AND (ligneApres.Fonction <> 'Vétérinaire' OR LigneApres.Fonction <> 'Infirmière'))
OR (ligneApres.Service = 'Surveillance' AND (ligneApres.Fonction <> 'Surveillant' OR LigneApres.Fonction <> 'Chef de zone'))
OR (ligneApres.Service = 'Administatif' AND (ligneApres.Fonction <> 'Secrétaire' OR LigneApres.Fonction <> 'Comptable' OR LigneApres.Fonction <> 'Chef du personnel' OR LigneApres.Fonction <> 'Directeur')))
BEGIN RAISE_APPLICATION_ERROR(-20001, 'La fonction et le service sont incompatibles.');
END;
/
SHOW ERR;

CREATE TRIGGER TauxEtGradeNonNul
AFTER INSERT OR UPDATE ON Employe
REFERENCING NEW AS ligneApres
FOR EACH ROW
WHEN ((ligneApres.Fonction = 'Surveillant' OR ligneApres.Fonction = 'Chef de zone') AND (ligneApres.Grade = NULL OR ligneApres.Taux = NULL))
BEGIN RAISE_APPLICATION_ERROR(-20002, 'Les surveillants doivent avoir un Taux et un Grade non nul.');
END;
/
SHOW ERR;

CREATE TRIGGER UneSeuleZoneParJour
AFTER INSERT OR UPDATE ON Surveillance
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE nbZones INTEGER;
BEGIN
SELECT COUNT(*) INTO nbZones
FROM Surveillance
WHERE CodeEmploye = :ligneApres.CodeEmploye
GROUP BY Jour
HAVING COUNT(CodeZone) > 1;
IF (nbZones > 0)
THEN RAISE_APPLICATION_ERROR(-20003, 'Un surveillant ne peut pas surveiller plus d''une zone par jour.');
END IF;
END;
/
SHOW ERR;

CREATE TRIGGER LotissementDifferentParHeure
AFTER INSERT OR UPDATE ON Surveillance
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE 
	LotissementPrecedent INTEGER;
	LotissementSuivant INTEGER;
BEGIN
SELECT CodeLotissement INTO LotissementPrecedent
FROM Surveillance
WHERE CodeEmploye = :ligneApres.CodeEmploye
AND Jour = :ligneApres.Jour
AND Heure = :ligneApres.Heure - 1;

SELECT CodeLotissement INTO LotissementSuivant
FROM Surveillance
WHERE CodeEmploye = :ligneApres.CodeEmploye
AND Jour = :ligneApres.Jour
AND Heure = :ligneApres.Heure + 1;

IF (:ligneApres.CodeLotissement = LotissementPrecedent OR :ligneApres.CodeLotissement = LotissementSuivant)
THEN RAISE_APPLICATION_ERROR(-20004, 'Un surveillant doit changer de lotissement toutes les heures.');
END IF;
END;
/
SHOW ERR;

CREATE TRIGGER UnSeulSurveillant
AFTER INSERT OR UPDATE ON Surveillance
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE nbSurveillant INTEGER;
BEGIN
SELECT COUNT(*) INTO nbSurveillant
FROM Surveillance
WHERE CodeLotissement = :ligneApres.CodeLotissement
AND Jour = :ligneApres.Jour
AND Heure = :ligneApres.Heure
AND CodeZone = :ligneApres.CodeZone
GROUP BY CodeLotissement
HAVING COUNT(CodeEmploye) > 1;
IF (nbSurveillant > 1)
THEN RAISE_APPLICATION_ERROR(-20005, 'Il ne peut pas avoir plus d''un surveillant par lotissement par zone par jour par heure.');
END IF;
END;
/
SHOW ERR;

CREATE TRIGGER LotissementsMemeZone
AFTER INSERT OR UPDATE ON Surveillance
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE nbZones INTEGER;
BEGIN
SELECT COUNT(*) INTO nbZones
FROM Surveillance
WHERE CodeEmploye = :ligneApres.CodeEmploye
AND Jour = :ligneApres.Jour
GROUP BY CodeEmploye
HAVING COUNT(CodeZone) > 1;
IF (nbZones > 1)
THEN RAISE_APPLICATION_ERROR(-20006, 'Tous les lotissements d''un surveillant pour un jour donné doivent être dans la même zone.');
END IF;
END;
/
SHOW ERR;

CREATE TRIGGER DateMesureDifferente
AFTER INSERT OR UPDATE ON Mesure
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE nbDates INTEGER;
BEGIN
SELECT COUNT(*) INTO nbDates
FROM Mesure
WHERE CodeIndividu = :ligneApres.CodeIndividu
GROUP BY DateMesure
HAVING COUNT(*) > 1;
IF (nbDates > 1)
THEN RAISE_APPLICATION_ERROR(-20007, 'Les dates des mesures d''un même individu doivent toutes être différentes.');
END IF;
END;
/
SHOW ERR;

SPOOL OFF;

SET ECHO OFF
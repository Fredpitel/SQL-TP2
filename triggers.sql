--
-- Script de creation des tables
-- Fr�d�ric Pitel;, Keven Blais
-- Code permanent: PITF16088608
-- Code permanent: BLAK29019305
-- 
SET ECHO ON

SPOOL triggers.res;
/
CREATE TRIGGER DateCoherente
BEFORE INSERT OR UPDATE ON Employe
REFERENCING NEW AS ligneApres
FOR EACH ROW
WHEN (SYSDATE < ADD_MONTHS(ligneApres.DateNaissance, 192))
BEGIN RAISE_APPLICATION_ERROR(-20000, 'L''employ� n''est pas assez �g�.');
END;
/
SHOW ERR;

CREATE TRIGGER FonctionCoherente
BEFORE INSERT OR UPDATE ON Employe
REFERENCING NEW AS ligneApres
FOR EACH ROW
WHEN((ligneApres.Service = 'M�dical' AND ligneApres.Fonction NOT IN ('V�t�rinaire', 'Infirmi�re'))
OR (ligneApres.Service = 'Surveillance' AND ligneApres.Fonction NOT IN ('Surveillant', 'Chef de zone'))
OR (ligneApres.Service = 'Administratif' AND ligneApres.Fonction NOT IN ('Secr�taire', 'Comptable', 'Chef du personnel', 'Directeur')))
BEGIN RAISE_APPLICATION_ERROR(-20001, 'La fonction et le service sont incompatibles.');
END;
/
SHOW ERR;

CREATE TRIGGER TauxEtGradeNonNul
BEFORE INSERT OR UPDATE ON Employe
REFERENCING NEW AS ligneApres
FOR EACH ROW
WHEN ((ligneApres.Fonction = 'Surveillant' OR ligneApres.Fonction = 'Chef de zone') AND (ligneApres.Grade IS NULL OR ligneApres.Taux IS NULL))
BEGIN RAISE_APPLICATION_ERROR(-20002, 'Les surveillants doivent avoir un Taux et un Grade non nul.');
END;
/
SHOW ERR;

CREATE TRIGGER UneSeuleZoneParJour
BEFORE INSERT OR UPDATE ON Surveillance
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE Code INTEGER;
BEGIN
SELECT DISTINCT CodeZone INTO Code
FROM Surveillance
WHERE CodeEmploye = :ligneApres.CodeEmploye
AND Jour = :ligneApres.Jour;
EXCEPTION WHEN NO_DATA_FOUND THEN Code := :ligneApres.CodeZone;
IF NOT(Code = :ligneApres.CodeZone)
THEN RAISE_APPLICATION_ERROR(-20003, 'Un surveillant ne peut pas surveiller plus d''une zone par jour.');
END IF;
END;
/
SHOW ERR;

CREATE TRIGGER LotissementParHeurePrecedent
BEFORE INSERT OR UPDATE ON Surveillance
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE LotissementPrecedent INTEGER;
BEGIN
SELECT CodeLotissement INTO LotissementPrecedent
FROM Surveillance
WHERE CodeEmploye = :ligneApres.CodeEmploye
AND Jour = :ligneApres.Jour
AND Heure = :ligneApres.Heure - 1;
EXCEPTION WHEN NO_DATA_FOUND THEN LotissementPrecedent := -1;
IF (:ligneApres.CodeLotissement = LotissementPrecedent)
THEN RAISE_APPLICATION_ERROR(-20004, 'Un surveillant doit changer de lotissement toutes les heures.');
END IF;
END;
/
SHOW ERR;

CREATE TRIGGER LotissementParHeureSuivant
BEFORE INSERT OR UPDATE ON Surveillance
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE LotissementSuivant INTEGER;
BEGIN
SELECT CodeLotissement INTO LotissementSuivant
FROM Surveillance
WHERE CodeEmploye = :ligneApres.CodeEmploye
AND Jour = :ligneApres.Jour
AND Heure = :ligneApres.Heure + 1;
EXCEPTION WHEN NO_DATA_FOUND THEN LotissementSuivant := -1;
IF (:ligneApres.CodeLotissement = LotissementSuivant)
THEN RAISE_APPLICATION_ERROR(-20004, 'Un surveillant doit changer de lotissement toutes les heures.');
END IF;
END;
/
SHOW ERR;

CREATE TRIGGER UnSeulSurveillant
BEFORE INSERT OR UPDATE ON Surveillance
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
EXCEPTION WHEN NO_DATA_FOUND THEN nbSurveillant := 0;
IF (nbSurveillant > 1)
THEN RAISE_APPLICATION_ERROR(-20005, 'Il ne peut pas avoir plus d''un surveillant par lotissement par zone par jour par heure.');
END IF;
END;
/
SHOW ERR;

CREATE TRIGGER LotissementsMemeZone
BEFORE INSERT OR UPDATE ON Surveillance
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
EXCEPTION WHEN NO_DATA_FOUND THEN nbZones := 0;
IF (nbZones > 1)
THEN RAISE_APPLICATION_ERROR(-20006, 'Tous les lotissements d''un surveillant pour un jour donn� doivent �tre dans la m�me zone.');
END IF;
END;
/
SHOW ERR;

CREATE TRIGGER DateMesureDifferente
BEFORE INSERT OR UPDATE ON Mesure
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE nbDates INTEGER;
BEGIN
SELECT COUNT(*) INTO nbDates
FROM Mesure
WHERE CodeIndividu = :ligneApres.CodeIndividu
GROUP BY DateMesure
HAVING COUNT(*) > 1;
EXCEPTION WHEN NO_DATA_FOUND THEN nbDates := 0;
IF (nbDates > 1)
THEN RAISE_APPLICATION_ERROR(-20007, 'Les dates des mesures d''un m�me individu doivent toutes �tre diff�rentes.');
END IF;
END;
/
SHOW ERR;

SPOOL OFF;

SET ECHO OFF
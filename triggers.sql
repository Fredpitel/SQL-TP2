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
BEFORE INSERT OR UPDATE ON Employe
REFERENCING NEW AS ligneApres
FOR EACH ROW
WHEN (SYSDATE < ADD_MONTHS(ligneApres.DateNaissance, 192))
BEGIN RAISE_APPLICATION_ERROR(-20000, 'L''employé n''est pas assez âgé.');
END;
/
SHOW ERR;

CREATE TRIGGER FonctionCoherente
BEFORE INSERT OR UPDATE ON Employe
REFERENCING NEW AS ligneApres
FOR EACH ROW
WHEN((ligneApres.Service = 'Médical' AND ligneApres.Fonction NOT IN ('Vétérinaire', 'Infirmière'))
OR (ligneApres.Service = 'Surveillance' AND ligneApres.Fonction NOT IN ('Surveillant', 'Chef de zone'))
OR (ligneApres.Service = 'Administratif' AND ligneApres.Fonction NOT IN ('Secrétaire', 'Comptable', 'Chef du personnel', 'Directeur')))
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
IF NOT Code = :ligneApres.CodeZone
THEN
RAISE_APPLICATION_ERROR(-20003, 'Un surveillant ne peut pas surveiller plus d''une zone par jour.');
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
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
IF (:ligneApres.CodeLotissement = LotissementPrecedent)
THEN RAISE_APPLICATION_ERROR(-20004, 'Un surveillant doit changer de lotissement toutes les heures.');
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
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
IF (:ligneApres.CodeLotissement = LotissementSuivant)
THEN RAISE_APPLICATION_ERROR(-20004, 'Un surveillant doit changer de lotissement toutes les heures.');
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END;
/
SHOW ERR;

CREATE TRIGGER UnSeulSurveillant
BEFORE INSERT OR UPDATE ON Surveillance
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE CodeSurveillant VARCHAR(3);
BEGIN
SELECT CodeEmploye INTO CodeSurveillant
FROM Surveillance
WHERE CodeLotissement = :ligneApres.CodeLotissement
AND Jour = :ligneApres.Jour
AND Heure = :ligneApres.Heure
AND CodeZone = :ligneApres.CodeZone;
IF NOT (CodeSurveillant IS NULL)
THEN RAISE_APPLICATION_ERROR(-20005, 'Il ne peut pas avoir plus d''un surveillant par lotissement par zone par jour par heure.');
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END;
/
SHOW ERR;

CREATE TRIGGER HeureDifferente
BEFORE INSERT OR UPDATE ON Surveillance
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE HeureExistante INTEGER;
BEGIN
SELECT Heure INTO HeureExistante
FROM Surveillance
WHERE CodeEmploye = :ligneApres.CodeEmploye
AND Jour = :ligneApres.Jour
AND Heure = :ligneApres.Heure;
IF NOT (HeureExistante IS NULL)
THEN RAISE_APPLICATION_ERROR(-20006, 'Un surveillant ne peut pas surveiller deux lotissement différents pendant la même heure');
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END;
/
SHOW ERR;

CREATE TRIGGER choixSurveillant
BEFORE INSERT OR UPDATE ON Choix
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE noZone INTEGER;
BEGIN
SELECT CodeZone INTO noZone
FROM Choix
WHERE CodeEmploye = :ligneApres.CodeEmploye
AND CodeZone = :ligneApres.CodeZone;
IF NOT (noZone IS NULL)
THEN RAISE_APPLICATION_ERROR(-20008, 'Un surveillant ne peut pas choisir une zone plus d''une fois.');
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END;
/

SHOW ERR;
CREATE TRIGGER choixAffinite
BEFORE INSERT OR UPDATE ON Choix
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE noAffinite INTEGER;
BEGIN
SELECT COUNT(Affinite) INTO noAffinite
FROM Choix
WHERE Affinite = :ligneApres.Affinite
AND CodeEmploye = :ligneApres.CodeEmploye;
IF(noAffinite = 3)
THEN RAISE_APPLICATION_ERROR(-20009,'L''une des affinitée a été choisie plus que 3 fois');
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END;
/
SHOW ERR;

CREATE TRIGGER choixLotissement
BEFORE INSERT OR UPDATE ON Espece
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE noLotissement INTEGER;
BEGIN
SELECT CodeLotissement INTO  noLotissement
FROM  Espece
WHERE CodeEspece = :ligneApres.CodeEspece;
IF(noLotissement <> :ligneApres.CodeLotissement)
THEN RAISE_APPLICATION_ERROR(-20010,'L''espèce possede déjà un lotissement');
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END;
/
SHOW ERR;
CREATE TRIGGER consecutifLotissement
BEFORE INSERT OR UPDATE ON Lotissement
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE noLotissement INTEGER;
BEGIN
SELECT MAX(CodeLotissement) INTO  noLotissement
FROM Lotissement
WHERE CodeZone = :ligneApres.CodeZone;
IF(:ligneApres.CodeLotissement <> noLotissement + 1 )
THEN RAISE_APPLICATION_ERROR(-20011,'L''ordre des lotissement doit être conséqutif');
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END;
/
SHOW ERR;

CREATE TRIGGER excluNombre
BEFORE INSERT OR UPDATE ON Individu
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE NombreEspece INTEGER;
BEGIN
SELECT Nombre INTO NombreEspece
FROM Espece
WHERE CodeEspece = :ligneApres.CodeEspece;
IF NOT(NombreEspece IS NULL)
THEN RAISE_APPLICATION_ERROR(-20012,'Nombre et individu ne peuvent être selectionnés silmultanément');
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END;
/
SHOW ERR;

CREATE TRIGGER parentEnfantMemeEspece
BEFORE INSERT OR UPDATE ON Individu
REFERENCING NEW AS ligneApres
FOR EACH ROW
DECLARE
  especePere INTEGER;
  especeMere INTEGER;
BEGIN
SELECT CodeEspece INTO especePere
FROM Individu
WHERE CodeIndividu = :ligneApres.Pere;
SELECT CodeEspece INTO especeMere
FROM Individu
WHERE CodeIndividu = :ligneApres.Mere;
IF(especePere = especeMere AND especePere <> :ligneApres.CodeEspece AND NOT especePere IS NULL)
THEN RAISE_APPLICATION_ERROR(-20014,'Si les parent sont de la même espèce alors l''enfant doit être lui aussi de la même espèce');
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END;
/
SHOW ERR;

CREATE TRIGGER siPereAlorsMere
BEFORE INSERT OR UPDATE ON Individu
REFERENCING NEW AS ligneApres
FOR EACH ROW
BEGIN
IF(NOT :ligneApres.Pere IS NULL AND :ligneApres.Mere IS NULL)
THEN RAISE_APPLICATION_ERROR(-20015,'Si le père est connu alors la mère doit aussi l''être.');
END IF;
END;
/
SHOW ERR;

SPOOL OFF;
SET ECHO OFF

--
-- Script de remplissage
-- Frédéric Pitel;, Keven Blais
-- Code permanent: PITF16088608
-- Code permanent: BLAK29019305
-- 

SET LINESIZE 160
SET ECHO ON

-- ecrire sql ici

INSERT INTO Employe
 	VALUES('111',123456789,'jean','auclair','','03/06/2000','2256 des quenouille','418-246-2789','concierge','service1',30,'G5')
/


INSERT INTO Salaire
 	VALUES('111',1,60000)
/


INSERT INTO Zones
 	VALUES(6,'reptile','111')
/


INSERT INTO Lotissement
 	VALUES(6,5,'laBelEpoque')
/

INSERT INTO Surveillance
 	VALUES('111',6,5,'lundi',14)
/

INSERT INTO Choix
 	VALUES('111',6,1)
/

INSERT INTO Espece
 	VALUES(1,'serpent',40,6,5)
/

INSERT INTO Individu
 	VALUES(1,'jeanLeSerpent',1,'A-','19-01-93',2,3)
/

INSERT INTO Mesure
 	VALUES(1,'',30,280)
/

SET ECHO OFF
SET PAGESIZE 30

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
 	VALUES('111',123456789,'jean','auclair',NULL,'03/06/2000','2256 des quenouille','418-246-2789','concierge','service1',30,'G5')
/

INSERT INTO Employe
 	VALUES('112',987654321,'bob','legoinfre',NULL,'03/06/1896','rue de la gloire','666-666-6666','THE BOSS','servic2',100,'G5')
/

INSERT INTO Salaire
 	VALUES('111',1,60000)
/

INSERT INTO Salaire
 	VALUES('112',1,200000)
/

INSERT INTO Zones
 	VALUES(6,'reptile','111')
/

INSERT INTO Zones
 	VALUES(5,'Oiseau','112')
/

INSERT INTO Lotissement
 	VALUES(6,5,'laBelEpoque')
/

INSERT INTO Lotissement
 	VALUES(5,1,'lot1')
/

INSERT INTO Surveillance
 	VALUES('111',6,5,'lundi',14)
/

INSERT INTO Surveillance
 	VALUES('112',5,1,'mardi',10)
/

INSERT INTO Choix
 	VALUES('111',6,1)
/

INSERT INTO Choix
 	VALUES('112',5,0)
/

INSERT INTO Espece
 	VALUES(1,'serpent',40,6,5)
/

INSERT INTO Espece
 	VALUES(2,'aigle',6,5,1)
/

INSERT INTO Individu
 	VALUES(1,'jeanLeSerpent',1,'A-','19-01-93',NULL,2,3)
/

INSERT INTO Individu
 	VALUES(4,'boblaigle',2,'A+','19-01-99',NULL,5,6)
/

INSERT INTO Mesure
 	VALUES(1,GETDATE(),70,280)
/

INSERT INTO Mesure
 	VALUES(4,GETDATE(),40,90)
/

SET ECHO OFF
SET PAGESIZE 30

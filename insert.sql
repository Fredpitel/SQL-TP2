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
 	VALUES('111',123456789,'jean','auclair',NULL,'2000/10/03','2256 des quenouille','418-246-2789','concierge','service1',30,'G5')
/

INSERT INTO Employe
 	VALUES('112',987654321,'bob','legoinfre',NULL,'1996/06/03','rue de la gloire','666-666-6666','THE BOSS','servic2',100,'G5')
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
 	VALUES('111',6,	5,'Lundi',14)
/

INSERT INTO Surveillance
 	VALUES('112',5,1,'Mardi',10)
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
 	VALUES(1,'jeanLeSerpent',1,'A-','1993/01/19',NULL,NULL,NULL)
/

INSERT INTO Individu
 	VALUES(4,'boblaigle',2,'A+','1999/01/27',NULL,NULL,NULL)
/

INSERT INTO Mesure
 	VALUES(1,sysdate,70,280)
/

INSERT INTO Mesure
 	VALUES(4,sysdate,40,90)
/

SET ECHO OFF
SET PAGESIZE 30

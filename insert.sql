--
-- Script de remplissage
-- Frédéric Pitel;, Keven Blais
-- Code permanent: PITF16088608
-- Code permanent: BLAK29019305
-- 

SET LINESIZE 160
SET ECHO ON

SET LINESIZE 160
SET ECHO ON

SPOOL insert.res;

INSERT INTO Employe
 	VALUES('ABC','111111111','Jean','Auclair',NULL,'1956/10/03','2256 des quenouille','514-111-1111','Directeur','Administratif',NULL,NULL)
/

INSERT INTO Employe
 	VALUES('BCD','222222222','Bob','Legoinfre',NULL,'1996/06/03','1234 rue de la gloire','514-222-2222','Chef du personnel','Administratif',NULL, NULL)
/

INSERT INTO Employe 
  VALUES ('CDE','333333333','Patenaude','Charles',NULL,'1985-10-03','2020 du finfin','514-333-3333','Comptable','Administratif',NULL,NULL)
/

INSERT INTO Employe 
  VALUES ('DEF','444444444','Montreui','Nicole',NULL,'1985-10-03','222 du crapaud','514-444-4444','Secrétaire','Administratif',NULL,NULL)
/

INSERT INTO Employe 
  VALUES ('EFG','555555555','Joubert','Martin',NULL,'1985-10-03','123 des oiseaux','514-555-5555','Vétérinaire','Médical',NULL,NULL)
/

INSERT INTO Employe 
  VALUES ('FGH','666666666','Bleau','Laurence',NULL,'1985-10-03','47 de Pragues','514-666-6666','Infirmière','Médical',NULL,NULL)
/

INSERT INTO Employe 
  VALUES ('GHI','777777777','Pitel','Frédéric',NULL,'1985-10-03','47 de Pragues','514-777-7777','Chef de zone','Surveillance',100,'G5')
/

INSERT INTO Employe 
  VALUES ('HIJ','888888888','Blais','Keven',NULL,'1985-10-03','28 des Paquerettes','514-888-8888','Chef de zone','Surveillance',100,'G5')
/

INSERT INTO Employe 
  VALUES ('IJH','999999999','Aubut','Marcel',NULL,'1985-10-03','5869 Papineau','514-999-9999','Surveillant','Surveillance',50,'G1')
/

INSERT INTO Employe 
  VALUES ('JHK','000000000','Paquette','Jean-Paul',NULL,'1985-10-03','6923 de Lorimier','514-000-0000','Surveillant','Surveillance',70,'G2')
/

INSERT INTO Salaire
 	VALUES('ABC',1,6000)
/

INSERT INTO Salaire
 	VALUES('ABC',2,6000)
/

INSERT INTO Salaire
 	VALUES('BCD',1,3000)
/

INSERT INTO Zones
 	VALUES(1,'Singe','GHI')
/

INSERT INTO Zones
 	VALUES(2,'Oiseaux','HIJ')
/

INSERT INTO Lotissement
 	VALUES(1,1,'Désert')
/

INSERT INTO Lotissement
 	VALUES(1,2,'Forêt')
/

INSERT INTO Lotissement
 	VALUES(2,1,'Jungle')
/

INSERT INTO Lotissement
 	VALUES(2,2,'Savane')
/

INSERT INTO Surveillance
 	VALUES('IJH',1,	1,'Lundi',9)
/

INSERT INTO Surveillance
 	VALUES('IJH',1,	2,'Lundi',10)
/

INSERT INTO Surveillance
 	VALUES('IJH',2,	2,'Mardi',16)
/

INSERT INTO Surveillance
 	VALUES('IJH',2,	1,'Mardi',17)
/

INSERT INTO Choix
 	VALUES('IJH',2,1)
/

INSERT INTO Choix
 	VALUES('IJH',1,0)
/

INSERT INTO Espece
 	VALUES(1,'Gorille',NULL,1,1)
/

INSERT INTO Espece
 	VALUES(2,'Moineau',30,2,1)
/

INSERT INTO Individu
 	VALUES(1,'Bobo',1,'A-','1993/01/19',NULL,NULL,NULL)
/

INSERT INTO Individu
 	VALUES(2,'Bobette',1,'A+','1992/07/26',NULL,NULL,NULL)
/

INSERT INTO Individu
 	VALUES(3,'Bobineau',1,'A+','2004/01/15',NULL,1,2)
/

INSERT INTO Mesure
 	VALUES(1,sysdate,300,220)
/

INSERT INTO Mesure
 	VALUES(2,sysdate,295,198)
/

COMMIT
/

SPOOL OFF;
SET ECHO OFF
SET PAGESIZE 30

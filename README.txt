Dans sql*plus executer les commandes suivantes pour chaque fichier *.sql:

Exemple pour create.sql
SPOOL create.res 
@create.sql
SPOOL OFF

--------------------------------------
Pour fichier insert.sql
--------------------------------------
Sa derniere ligne doit etre 
COMMIT;

--------------------------------------
Pour fichier triggers.sql
--------------------------------------
Apres END; de chaque trigger
SHOW ERR;

--------------------------------------
Pour fichier tests.sql
--------------------------------------
Apres chaque test 
ROLLBACK
pour annuler les changements apportes

TRIGGERS À FAIRE

Fred:
- Vérifier que Fonction et Service sont cohérents  ---FAIT---
- Si employé est Surveillant ou Chef de Zone, Taux et Grade NOT NULL  ---FAIT---
- Un seul Chef par Zone  ---FAIT---
- Surveillant surveille une seule zone par jour  ---FAIT---
- Surveillant change de lotissement toutes les heures  ---FAIT---
- Un seul Surveillant par lotissement par heure  ---FAIT---
- Tous les lotissements surveillés par un Surveillant pendant une journée sont dans la même zone.  ---FAIT---
- Toutes les mesures du même Individu ont des dates différentes  ---FAIT---

Keven:
- Choix: Zone choisie une seule fois par surveillant  ---FAIT---
- Choix: Affinité 0 et 1 maximum 3 choix chaque  ---FAIT---
- Une espece est toujours dans un seul lotissement  ---FAIT---
- Zone: numéro de lotissement sont consécutifs   ---FAIT---
- Espece: Nombre et Individu mutuellement exclusif ---FAIT---
- Date de naissance et déces des parents cohérents ---FAIT---
- Si parents sont de la même espèce alors individu apartient à la même espèce
- Si Père est connu alors Mère est connue




index (pour word)
Salaire
 -ICodeEmployeSalaire(CodeEmploye) 
Surveillance
 -ICodeEmployeSurveillance(CodeEmploye) 
Choix
-ICodeEmployeChoix(CodeEmploye) 
Lotissement
-ICodeZoneLotissement(CodeZone) 
Surveillance
-ICodeZoneSurveillance(CodeZone) 
Choix
-ICodeZoneChoix(CodeZone) 
Espece
-ICodeZoneEspece(CodeZone) 

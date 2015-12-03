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
- Vérifier que Fonction et Service sont cohérents
- Si employé est Surveillant ou Chef de Zone, Taux et Grade NOT NULL
- Un seul Chef par Zone
- Surveillant surveille une seule zone par jour
- Surveillant change de lotissement toutes les heures
- Un seul Surveillant par lotissement par heure
- Tous les lotissements surveillés par un Surveillant pendant une journée sont dans la même zone.
- Toutes les mesures du même Individu ont des dates différentes

Keven:
- Choix: Zone choisie une seule fois par surveillant
- Choix: Affinité 0 et 1 maximum 3 choix chaque
- Une espece est toujours dans un seul lotissement
- Zone: numéro de lotissement sont consécutifs
- Espece: Nombre et Individu mutuellement exclusif
- Date de naissance et déces des parents cohérents
- Si parents sont de la même espèce alors individu apartient à la même espèce
- Si Père est connu alors Mère est connue

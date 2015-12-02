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


Recette pour une stratégie de backup/restauration simple avec des outils standards linux:

Ingrédients:
  - cron pour la plannification de la tâche de backup
  - rsync / ssh pour la synchronisation entre serveur source -> serveur backup
  - Gnu gpg (encryption/décription) -> pour encrypter les backups
  - Tar / Zip -> pour compresser les backup
  - Bash -> pour le scripting


Recette:
  - Créer un script bash qui va:
       - créer un dossier avec la date du jour dans le dossier MesBakcups
       - copier les fichiers du dossier "MesDocuments" dans le dossier créé
       - encrypter les fichiers avec gpg
       - compresser le dossier créé avec tar ou zip
       - exécuter la commande rsync 
            exemple: rsync -avz MesBackups/dossier-16-04-2025.zip root@mon-serveur-backup.be:/opt/mes-backups
  - ajouter une tâche cron qui va se lancer tout les jours à 2h du matin et qui va appeler le script bash défini ci dessus



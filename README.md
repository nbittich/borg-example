1) démarrer les containeurs docker:

`docker compose up -d`

2) tester la connectivité sur les différents serveurs:
   2.1) Tester sur server1:
        - `docker compose exec server1 bash`
        - `ssh root@backup-server` # répondre "Yes" pour l'ajout de la clé ssh

   2.2) Tester sur server2:
        - `docker compose exec server2 bash`
        - `ssh root@backup-server` # répondre "Yes" pour l'ajout de la clé ssh
   2.3) Tester sur backup-server:
        - `docker compose exec backup-server bash`
        - `ssh root@server1` # répondre "Yes" pour l'ajout de la clé ssh
        - `ssh root@server2` # répondre "Yes" pour l'ajout de la clé ssh
3) Initialiser le repository borg, deux options:
    - directement depuis le serveur backup:
            * `docker compose exec backup-server bash`
            * `borg init --encryption=repokey /mesbackups` # mettre un mot de passe, confirmer le mot de passe
    - à distance depuis le server1:
            * `docker compose exec server1 bash`
            * `borg init --encryption=repokey root@backup-server:/mesbackups` # mettre un mot de passe, confirmer le mot de passe
4) Créer une backup du server1 (le dossier /server1files):
        - `docker compose exec server1 bash`
        - `borg create root@backup-server:/mesbackups::backup1 /server1files`
5) Créer une backup du server2 (le dossier /server2files):
        - `docker compose exec server2 bash`
        - `borg create root@backup-server:/mesbackups::backup2 /server2files`
6) Lister les backups:
        - `docker compose exec backup-server bash`
        - `borg list /mesbackups`
7) Lister les fichiers d'une backup (la backup1 par exemple):
        - `docker compose exec backup-server bash`
        - `borg list /mesbackups::backup1`
8) Restaurer la backup du serveur 2 sur le serveur 1:
            * `docker compose exec server1 bash`
            * `borg extract root@backup-server:/mesbackups::backup2` # les fichiers devraient être au niveau de /server2files


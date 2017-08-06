#!/bin/bash
docker exec vagrant_mariadb_1 sh -c 'exec mysqldump --all-databases -uroot' > backups/$(date --iso-8601=minutes).sql


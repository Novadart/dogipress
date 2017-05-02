#!/bin/bash

# Before shutting down, copy the database
mysqldump -h 127.0.0.1 -P 8081 --user=root --password="wordpress" --result-file=db/database.sql wordpress

docker-compose down
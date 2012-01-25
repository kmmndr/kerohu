#!/bin/bash

USER=$1
PASS=$USER
DB=$USER

if [ "aa$USER" == "aa" ]; then
  exit
fi

cat << EOF
-- creating database
create database $USER;
-- allowing to connect
grant usage on *.* to $USER@localhost identified by '$PASS';
-- allowing to perform everything on the new database
grant all privileges on $DB.* to $USER@localhost;
EOF


#!/bin/bash

USER=$1
PASS=$USER
DB=$USER
error=0

if [ "aa$USER" == "aa" ]; then
  error=1
fi

case $DB in
"information_schema")
  error=1
  ;;
"mysql")
  error=1
  ;;
*) ;;
esac

if [ $error -eq 1 ]; then
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


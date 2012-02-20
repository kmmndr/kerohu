#!/bin/bash

USER=$1
PASS=$USER
DB=$USER
error=0

if [ "aa$USER" == "aa" ]; then
  error=1
fi

case $DB in
"postgres")
  error=1
  ;;
"template0")
  error=1
  ;;
"template1")
  error=1
  ;;
*) ;;
esac

if [ $error -eq 1 ]; then
  exit
fi

cat << EOF
-- allowing to connect
create user $USER with password '$PASS';
-- creating database
create database $DB;
-- allowing to perform everything on the new database
grant all privileges on database $DB to $USER;
EOF


#!/bin/bash
set -e

APP_ADDRESS=$1

if [ "$APP_ADDRESS" = "" ]; then
  printf "Please provide application address as a first argument."
  exit 1
fi

cd $APP_ADDRESS

printf "\nkillall node"
killall node

printf "\ngit fetch origin"
git fetch origin
printf "\ngit checkout dev"
git checkout dev
printf "\ngit diff origin/dev"
if [[ $(git diff origin/dev) ]]; then
  printf "\ngit rebase origin/dev"
  git rebase origin/dev
fi

cd database

printf "\nmysql -u \"root\" -p \"root\" < \"./drop_database.sql\""
mysql -u "root" -p "root" < "./drop_database.sql"
printf "\nmysql -u \"root\" -p \"root\" < \"./database_schema.sql\""
mysql -u "root" -p "root" < "./database_schema.sql"
printf "\nmysql -u \"root\" -p \"root\" < \"./test_data_insert.sql\""
mysql -u "root" -p "root" < "./test_data_insert.sql"

cd ..

node index.js





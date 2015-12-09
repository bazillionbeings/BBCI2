#!/bin/bash
#set +e

APP_ADDRESS=$1

if [ "$APP_ADDRESS" = "" ]; then
  printf "Please provide application address as a first argument.\n"
  exit 1
fi

cd $APP_ADDRESS

printf "killall node\n"
killall node

printf "git fetch origin\n"
git fetch origin
printf "git checkout dev\n"
git checkout dev
printf "git diff origin/dev\n"
if [[ $(git diff origin/dev) ]]; then
  printf "git rebase origin/dev\n"
  git rebase origin/dev
fi

cd database

printf "mysql -u \"root\" -p \"root\" < \"./drop_database.sql\"\n"
mysql -u "root" -p "root" < "./drop_database.sql"
printf "mysql -u \"root\" -p \"root\" < \"./database_schema.sql\"\n"
mysql -u "root" -p "root" < "./database_schema.sql"
printf "mysql -u \"root\" -p \"root\" < \"./test_data_insert.sql\"\n"
mysql -u "root" -p "root" < "./test_data_insert.sql"

cd ..

node index.js





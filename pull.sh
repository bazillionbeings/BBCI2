#!/bin/bash
#set +e

APP_ADDRESS=$1
MYSQL_USER="root"
MYSQL_PASSWORD="root"
printf "test"
if [ "$APP_ADDRESS" = "" ]; then
  printf "Please provide application address as a first argument.\n"
  exit 1
fi

cd $APP_ADDRESS

printf "git fetch origin\n"
git fetch origin

#printf "git checkout dev\n"
#git checkout dev
printf "git diff origin/dev\n"
if [[ $(git diff origin/dev) ]]; then
  printf "git rebase origin/dev\n"
  git rebase origin/dev

  cd database

  printf "mysql --user=\"root\" --password=\"root\" < \"./drop_database.sql\"\n"
  mysql --user="root" --password="root" < "./drop_database.sql"
  printf "mysql --user=\"root\" --password=\"root\" < \"./database_schema.sql\"\n"
  mysql --user="root" --password="root" < "./database_schema.sql"
  printf "mysql --user=\"root\" --password=\"root\" < \"./test_data_insert.sql\"\n"
  mysql --user="root" --password="root" < "./test_data_insert.sql"

  cd ..

  printf "npm install\n"
  npm install
else
  printf "no changes detected\n"
fi

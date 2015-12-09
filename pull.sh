#!/bin/bash
set -e

APP_ADDRESS=$1

if [ "$APP_ADDRESS" = "" ]; then
  echo "Please provide application address as a first argument."
  exit 1
fi

cd $APP_ADDRESS

echo "\nkilling node process"
killall node

echo "\npulling"
git fetch origin
git checkout dev
if [[ $(git diff origin/dev) ]]; then
    git rebase origin/dev
fi

cd database
mysql -u "root" -p "root" < "./drop_database.sql"
mysql -u "root" -p "root" < "./database_schema.sql"
mysql -u "root" -p "root" < "./test_data_insert.sql"

cd ..

node index.js





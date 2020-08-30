#!/usr/bin/env bash

echoTitle() {
  echo -e "\033[0;30m\033[42m -- $1 -- \033[0m"
}

cd ~/www/api

echoTitle "Create backup and update changes with git"
git stash  && git branch backup-$(date +"%y%m%d-%H%M") && git checkout master && git pull

cd ./www

echoTitle "Set ENV for production"
cp ~/secret/.env.prod .env

echoTitle "Run composer update"
#php ../../composer.phar update --no-dev --optimize-autoloader && php ../../composer.phar dumpautoload -o -a
/home/gonzalosantos/.bin/php ../../composer.phar update --prefer-dist --no-scripts --optimize-autoloader

echoTitle "Run composer auto-scripts"
/home/gonzalosantos/.bin/php ../../composer.phar run-script auto-scripts

#Running any database migrations
#Clearing your APCu cache
#Add/edit CRON jobs
#Building and minifying your assets with Webpack Encore
#Pushing assets to a CDN
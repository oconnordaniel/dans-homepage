#!/bin/sh
git pull
JEKYLL_ENV=production bundle exec jekyll b

docker stop dans-homepage
sleep 5
docker build . -t dans-homepage
sleep 5
docker run -d -p 80:80 --name dans-homepage --restart unless-stopped dans-homepage

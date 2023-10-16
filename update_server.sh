#!/bin/sh
echo "Pulling fresh from github"
git pull

echo "Rebuilding jekyll"
JEKYLL_ENV=production bundle exec jekyll b

echo "Stopping dans-homepage docker"
docker stop dans-homepage

echo "removeing dans-homepage docker"
docker rm dans-homepage

echo "Building new image"
docker build . -t dans-homepage

echo "Running dans-homepage"
docker run -d -p 80:80 --name dans-homepage --restart unless-stopped dans-homepage

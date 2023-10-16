git pull
JEKYLL_ENV=production bundle exec jekyll b

docker stop dans-homepage

docker build . -t dans-homepage
docker run -d -p 80:80 --name dans-homepage --restart unless-stopped dans-homepage

# Read me

## Project outline

1. Build Jekyll

    On Ubuntu

    ``` bash
    sudo apt update
    sudo apt install ruby-full build-essential zlib1g-dev git
    ```

    On MacOS

    ``` bash
    brew install chruby ruby-install xz
    ```

    Install bundler

    ``` bash
    gem install jekyll bundler
    cd project-file
    bundle
    ```

2. Modify jekyll config

3. Update config file

4. Add pages

5. Build for prod

    ``` bash
    bundle exec jekyll s
    JEKYLL_ENV=production bundle exec jekyll b
    ```

6. Docker build with

    ``` bash
    docker build . -t dans-homepage
    docker run -d -p 80:80 dans-homepage
    ```

7. Push dockerfile to AWS?

## Resources

<https://motherfuckingwebsite.com/>

<http://bettermotherfuckingwebsite.com/>

<https://perfectmotherfuckingwebsite.com/>

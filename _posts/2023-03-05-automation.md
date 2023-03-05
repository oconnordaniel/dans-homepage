---
title: Automating the posts to dans site
date: 2023-03-05 10:00:00 -700
catagories: [github, ansible]
tags: [github, actions, ansible, automation]
---

So... now that we have a site with a post, I now have to figure out how to automate adding more posts.

Of corse my first thought was just make some .sh files to handle all the updates.

    - Add a .md file to _posts
    - `bundle jekyll` to build the site folder
    - git push
    - ssh to the ec2 instance
    - git pull
    - docker stop, rm, build, run, left, right, up, down

So.... no. I could do it like that, but I don't have the time or skills to build in all the `try do catch` stuff needed to make sure that if things broke, they break before they go live.

## Automation

That means the next step is of corse automation. The professinal way.

### Setp 1. docker-compose

Since this site is just nginx alpine and hand that some files, I can actually just spin the whole thing up in a docker-compose file.

```yml
services:

dans-homepage: 
    image: nginx:stable-alpine
    ports: 
    - 80:80
    volumes:
    - ./_site/:/usr/share/nginx/html
    restart: always 
```

That was simple. And best of all that means I don't need to re-start or rebuild the docker image after a post.

### Step 2. Ansible

The next step is to have a task that tells my instance to git pull and if there are changes, run the `bundle jekyll` command to put format the post and put it in the `_site` folder.

```yml
- hosts: all
  tasks: 
    - name: Pull the latest main branch from github
      ansible.builtin.git:
        repo: 'https://github.com/oconnordaniel/dans-homepage.git'
        dest: /home/ubuntu/dans-homepage
      notify: build_server

    - community.docker.docker_compose:
        project_name: dans-homepage
        definition:
          version: '2'
          services:
            dans-homepage:
              image: nginx:stable-alpine
              volumes:
                - /home/ubuntu/dans-homepage/_site/:/usr/share/nginx/html/
              ports:
                - "80:80"

  handlers:
    - name: build_server
      ansible.builtin.shell: 
        executable: /bin/bash
        cmd: JEKYLL_ENV=production /home/ubuntu/gems/bin/bundle exec jekyll b
        chdir: /home/ubuntu/dans-homepage
```

And ta-da! Once I'm done making a post in the _post folder, I can `git push` it then run

``` bash
ansible-playbook ansible-play/deploy.yml
```

and my site is updated. 

### Step 3. Github action

Next step will be to get gethub actions to run my ansible play. But that's another post. 


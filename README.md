Symfony3-docker
========

Run project in docker

1) Install docker and docker-compose (preferably from docker.com)
2) Create .env file based on docker.env and edit parameters accordingly to your environment and do "git clone" for your project
3) Turn off any services which listen to port 80
4) Run docker-compose up (try with "sudo" if does not work)
5) Create app/config/parameters.yml based on app/config/parameters.yml.dist
- use "db" as database host
- use parameters from .env for database pass, user and DB name
6) Add a new record to your hosts file: 0.0.0.0 domain.local . Or whatever you want to use instead of domain.local
7) Connect to running docker container
- as non-root user to avoid file permission issues: docker exec -it -u develop symfony3docker_app_1 bash
- also you can connect as root: docker exec -it symfony3docker_app_1 bash
8) Set up project
- composer install
- set up DB: bin/console doctrine:migrations:migrate & bin/console doctrine:fixtures:load
- do whatever you need to install and compile assets
9) For graceful shut down use: docker-compose stop. Or just CTRL+C.
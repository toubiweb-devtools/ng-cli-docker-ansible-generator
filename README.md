# ng-cli-docker-ansible-generator

Ansible generator to bootstrap a ng-cli + ansible/docker project

## What does this generator?

This ansible playbook does the following actions:
- generate docker development environment (dockerfile, docker-compose, sh scripts)
- build docker development image based on node, npm & ng-cli
- run "ng-cli" with the required parameters inside a docker container
- update package.json to allow running "ng serve" from inside the container
- generate scripts to start/stop/enter the development container
- install additionnal dependencies

## Prerequisites

- ansible
- docker
- docker-compose
- docker-py (pip install)

## Usage

Make a copy of config/example-app.yml and configure it according to your requirements.

Then run:

```bash
./ng-cli.sh
```

or

```bash
 ./ng-cli.sh --config=example-app.yml
 ```

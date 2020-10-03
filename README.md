# github-action-deploy
github action for automatic deployment of through ssh

## Example usage

name: Continous Integration

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: ./www
    steps:
      - name: 'Deploy'
        uses: gonsandia/github-action-deploy@master
        with:
          SSH_USER: ${{ secrets.HEZTNER_MR_SSH_USER }}
          SSH_HOST: ${{ secrets.HEZTNER_MR_SSH_HOST }}
          SSH_PASSWORD: ${{ secrets.HEZTNER_MR_SSH_PASSWORD }}
          SSH_KEY: ${{ secrets.HEZTNER_MR_SSH_KEY }}
          SSH_PORT: ${{ secrets.HEZTNER_MR_SSH_PORT }}
          SSH_SCRIPT: |-
            #!/usr/bin/env bash
            cd ~/repository
            git stash  && git branch backup-$(date +"%y%m%d-%H%M") && git checkout master && git pull
            cd ./www
            cp ~/secret/.env.prod .env
            composer update --prefer-dist --no-scripts --optimize-autoloader --ignore-platform-reqs
            composer run-script auto-scripts

### Local Launch

    docker build -t github-action-deploy:latest . && docker run --name deploy github-action-deploy:latest 

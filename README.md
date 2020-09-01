# github-action-deploy

## Example usage

  jobs:
    build:
      runs-on: ubuntu-latest
      defaults:
        run:
          working-directory: ./www
      steps:
          - name: 'Deploy'
          uses: gonsandia/github-action-deploy
          with:
            SSH_USER: ${{ secrets.STAGING_SSH_USER }}
            SSH_HOST: ${{ secrets.STAGING_SSH_HOST }}
            SSH_PASSWORD: ${{ secrets.STAGING_SSH_PASSWORD }}
            SSH_KEY: ${{ secrets.STAGING_SSH_KEY }}
            SSH_PORT: ${{ secrets.STAGING_SSH_PORT }}
            SSH_SCRIPT: |-
              #!/usr/bin/env bash
              cd ~/www/api
              git stash  && git branch backup-$(date +"%y%m%d-%H%M") && git checkout master && git pull
              cd ./www
              cp ~/secret/.env.prod .env
              /home/gonzalosantos/.bin/php ../../composer.phar update --prefer-dist --no-scripts --optimize-autoloader
              /home/gonzalosantos/.bin/php ../../composer.phar run-script auto-scripts

### Local Launch

    docker build -t github-action-deploy:latest . && docker run --name deploy github-action-deploy:latest 

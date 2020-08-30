# github-action-deploy

## Example usage

    uses: gonsandia/github-action-deploy
    with:
      SSH_USER: ${{ secrets.STAGING_SSH_USER }}
      SSH_HOST: ${{ secrets.STAGING_SSH_HOST }}
      SSH_PASSWORD: ${{ secrets.STAGING_SSH_PASSWORD }}
      SSH_KEY: ${{ secrets.STAGING_SSH_KEY }}
      SSH_PORT: ${{ secrets.STAGING_SSH_PORT }}

### Local Launch

    docker build -t github-action-deploy:latest . && docker run --name deploy github-action-deploy:latest 
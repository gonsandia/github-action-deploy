#!/usr/bin/env bash

source "$HOME_DIR/src/ensure.sh"
source "$HOME_DIR/src/format.sh"

main() {
  ensure::env_variable_exist "INPUT_SSH_USER"
  ensure::env_variable_exist "INPUT_SSH_HOST"
  ensure::env_variable_exist "INPUT_SSH_PORT"
  ensure::env_variable_exist "INPUT_SSH_SCRIPT"

  if [[ -z "$INPUT_SSH_HOST" ]]; then
    format::echoTitle "Building"
    exit 0
  fi

  format::echoTitle "Prepare deploy script"
  echo "$INPUT_SSH_SCRIPT" | cat > $HOME_DIR/src/deploy.sh
  cat $HOME_DIR/src/deploy.sh

  format::echoTitle "Provisioning virtual machine..."

  if [[ ! -z "$INPUT_SSH_KEY" ]]; then
    ensure::env_variable_exist "INPUT_SSH_KEY"

    mkdir -p ~/.ssh/
    echo "$INPUT_SSH_KEY" > ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa
    cat $HOME_DIR/src/deploy.sh | ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa $INPUT_SSH_USER@$INPUT_SSH_HOST -p $INPUT_SSH_PORT
  else
    ensure::env_variable_exist "INPUT_SSH_PASSWORD"

    format::echoTitle "Connecting ssh with sshpass"

    cat $HOME_DIR/src/deploy.sh | sshpass -p $INPUT_SSH_PASSWORD ssh -o StrictHostKeyChecking=no $INPUT_SSH_USER@$INPUT_SSH_HOST -p $INPUT_SSH_PORT
  fi

  exit $?
}
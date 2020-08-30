#!/usr/bin/env bash

ensure::env_variable_exist() {
  format::echoTitle "Verify if $1 env variable exists"
  if [[ -z "${!1}" ]]; then
    echo "The env variable $1 is required."
    exit 1
  fi
}
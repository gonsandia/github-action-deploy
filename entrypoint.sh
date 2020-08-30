#!/usr/bin/env bash

#set -euo pipefail

HOME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

if [ "$HOME_DIR" == "/" ]; then
  HOME_DIR=""
fi

export HOME_DIR

bash --version

source "$HOME_DIR/src/main.sh"

main "$@"

echo $?

exit $?
#!/usr/bin/env bash
# Prosody user management helper
set -e

CONTAINER="wgv3-prosody"
DOMAIN="${DOMAIN:-localhost}"

usage() {
  echo "Usage: $0 [add|del|passwd|list] [username]"
  echo ""
  echo "  add    <username>  Add user <username>@$DOMAIN"
  echo "  del    <username>  Delete user"
  echo "  passwd <username>  Change password"
  echo "  list               List all users"
  echo ""
  echo "Set DOMAIN env var to change domain (default: localhost)"
  exit 1
}

case "$1" in
  add)
    [ -z "$2" ] && usage
    docker exec -it $CONTAINER prosodyctl adduser "$2@$DOMAIN"
    echo "User $2@$DOMAIN created."
    ;;
  del)
    [ -z "$2" ] && usage
    docker exec -it $CONTAINER prosodyctl deluser "$2@$DOMAIN"
    echo "User $2@$DOMAIN deleted."
    ;;
  passwd)
    [ -z "$2" ] && usage
    docker exec -it $CONTAINER prosodyctl passwd "$2@$DOMAIN"
    ;;
  list)
    docker exec -it $CONTAINER prosodyctl list users $DOMAIN
    ;;
  *)
    usage
    ;;
esac

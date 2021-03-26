#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for kicksoccerd"

  set -- kicksoccerd "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "kicksoccerd" ]; then
  mkdir -p "$KICKSOCCER_DATA"
  chmod 700 "$KICKSOCCER_DATA"
  chown -R kicksoccer "$KICKSOCCER_DATA"

  echo "$0: setting data directory to $KICKSOCCER_DATA"

  set -- "$@" -datadir="$KICKSOCCER_DATA"
fi

if [ "$1" = "kicksoccerd" ] || [ "$1" = "kicksoccer-cli" ] || [ "$1" = "kicksoccer-tx" ]; then
  echo
  exec gosu kicksoccer "$@"
fi

echo
exec "$@"
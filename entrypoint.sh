#!/bin/bash
wait-hosts

if [ -d /docker-entrypoint-init.d ]
then
	if [ "$(ls -A /docker-entrypoint-init.d/)" ]
	then
		for f in /docker-entrypoint-init.d/*; do
  		echo "     - Running $f"
  		bash "$f" -H 
		done
	fi
fi

cd /app

set -e
# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- pnpm run dev "$@"
fi
exec "$@"
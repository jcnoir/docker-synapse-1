#!/bin/sh -eu

if [[ -n "$GID" ]]; then
    groupmod -o -g $GID synapse
fi

if [[ -n "$UID" ]]; then
    usermod -o -u $UID synapse
fi

case "$1" in
    generate)
        exec su-exec synapse python -m synapse.app.homeserver \
            --generate-config \
            --config-path /config/homeserver.yaml \
            --server-name "$2"
    ;;
    *)
        exec su-exec synapse python -m synapse.app.homeserver \
            --config-path /config/homeserver.yaml
    ;;
esac

#!/bin/sh -eu

if [[ -n "$GID" ]]; then
    groupmod -o -g $GID synapse
fi

if [[ -n "$UID" ]]; then
    usermod -o -u $UID synapse
fi

exec su-exec synapse "$@" $ARGS

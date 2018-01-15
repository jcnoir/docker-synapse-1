# docker-synapse
Production-grade, alpine-sized version of matrix.org's Synapse

# Getting started

You will need to generate a config, keys etc...

Do so by adding "generate" and "your-server-name" as CMD arguments

```
docker run \
    --name synapse \
    --rm \
    --read-only \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -v $PWD/config:/config \
    -v $PWD/data:/data \
    -p 8448:8448 \
    -p 8008:8008 \
    robertbeal/synapse generate kohi.uk
```

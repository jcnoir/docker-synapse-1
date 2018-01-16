# docker-synapse
Production-grade, alpine-sized version of matrix.org's Synapse

# Getting started

You will need to generate a config, keys etc...

Do so by adding "generate" and "your-server-name" as CMD arguments (see below)

```
docker run \
    --name synapse \
    --rm \
    -e UID=$(id -u) \
    -e GID=$(id -g) \
    -v $PWD/config:/config \
    -v $PWD/data:/data \
    -p 8448:8448 \
    -p 8008:8008 \
    robertbeal/synapse generate kohi.uk
```

Some of the default config paths point at root... let's clean that up:

sed -i \
    -e '/database: / s@"/homeserver.db"@"/data/homeserver.db"@' \
    -e '/log_file: / s@"/homeserver.log"@"/data/homeserver.log"@' \
    -e '/media_store_path: / s@"/media_store"@"/data/media"@' \
    -e '/uploads_path:/ s@"/uploads"@"/data/uploads"@' \
    $PWD/config/homeserver.yaml
sed -i \
    -e '/filename: / s@/homeserver.log@/data/homeserver.log@' \
    $PWD/config/kohi.uk.log.config

# Running the server

```
docker run \
    --name synapse \
    --rm \
    -e UID=$(id -u) \
    -e GID=$(id -g) \
    -v $PWD/config:/config \
    -v $PWD/data:/data \
    -p 8448:8448 \
    -p 8008:8008 \
    robertbeal/synapse
```


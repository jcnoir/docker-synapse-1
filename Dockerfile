FROM alpine:3.7

ENV VERSION=v0.26.0

RUN apk --no-cache add --virtual=build-dependencies \
    build-base \
    python2-dev \
  && apk --no-cache add \
    ca-certificates \
    py2-asn1 \
    py2-asn1-modules \
    py2-bcrypt \
    py2-cffi \
    py2-crypto \
    py2-cryptography \
    py2-dateutil \
    py2-decorator \
    py2-jinja2 \
    py2-jsonschema \
    py2-ldap3 \
    py2-msgpack \
    py2-netaddr \
    py2-openssl \
    py2-phonenumbers \
    py2-pillow \
    py2-pip \
    py2-psutil \
    py2-psycopg2 \
    py2-requests \
    py2-service_identity \
    py2-simplejson \
    py2-tz \
    py2-yaml \
    py-twisted \
    shadow \
    su-exec \
    tini \
  && pip install https://github.com/matrix-org/synapse/archive/$VERSION.tar.gz \
  && apk del --purge build-dependencies \
  && adduser -u 2800 -S -h /data synapse

COPY entrypoint.sh /usr/local/bin
VOLUME /config /data
EXPOSE 8448 8008

ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
CMD["python", "-m", "synapse.app.homeserver", "--config-path", "/config/homeserver.yaml"]

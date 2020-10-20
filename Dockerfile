FROM alpine:3.11

# ===============
# Alpine packages
# ===============

RUN apk update \
    && apk add --no-cache py3-pip curl tini \
    && apk add --no-cache --virtual build-deps git wget

# ======
# Python
# ======

RUN apk add --no-cache py3-cryptography py3-multidict py3-yarl
COPY requirements.txt /app/requirements.txt
RUN pip3 install -U pip \
    && pip3 install --no-cache-dir -r /app/requirements.txt \
    && rm -rf /src/jans-pycloudlib/.git

# =======
# Cleanup
# =======

RUN apk del build-deps \
    && rm -rf /var/cache/apk/*

# =======
# License
# =======

RUN mkdir -p /licenses
COPY LICENSE /licenses/

# ==========
# Config ENV
# ==========

ENV CLOUD_NATIVE_CONFIG_ADAPTER=consul \
    CLOUD_NATIVE_CONFIG_CONSUL_HOST=localhost \
    CLOUD_NATIVE_CONFIG_CONSUL_PORT=8500 \
    CLOUD_NATIVE_CONFIG_CONSUL_CONSISTENCY=stale \
    CLOUD_NATIVE_CONFIG_CONSUL_SCHEME=http \
    CLOUD_NATIVE_CONFIG_CONSUL_VERIFY=false \
    CLOUD_NATIVE_CONFIG_CONSUL_CACERT_FILE=/etc/certs/consul_ca.crt \
    CLOUD_NATIVE_CONFIG_CONSUL_CERT_FILE=/etc/certs/consul_client.crt \
    CLOUD_NATIVE_CONFIG_CONSUL_KEY_FILE=/etc/certs/consul_client.key \
    CLOUD_NATIVE_CONFIG_CONSUL_TOKEN_FILE=/etc/certs/consul_token \
    CLOUD_NATIVE_CONFIG_KUBERNETES_NAMESPACE=default \
    CLOUD_NATIVE_CONFIG_KUBERNETES_CONFIGMAP=gluu \
    CLOUD_NATIVE_CONFIG_KUBERNETES_USE_KUBE_CONFIG=false

# ==========
# Secret ENV
# ==========

ENV CLOUD_NATIVE_SECRET_ADAPTER=vault \
    CLOUD_NATIVE_SECRET_VAULT_SCHEME=http \
    CLOUD_NATIVE_SECRET_VAULT_HOST=localhost \
    CLOUD_NATIVE_SECRET_VAULT_PORT=8200 \
    CLOUD_NATIVE_SECRET_VAULT_VERIFY=false \
    CLOUD_NATIVE_SECRET_VAULT_ROLE_ID_FILE=/etc/certs/vault_role_id \
    CLOUD_NATIVE_SECRET_VAULT_SECRET_ID_FILE=/etc/certs/vault_secret_id \
    CLOUD_NATIVE_SECRET_VAULT_CERT_FILE=/etc/certs/vault_client.crt \
    CLOUD_NATIVE_SECRET_VAULT_KEY_FILE=/etc/certs/vault_client.key \
    CLOUD_NATIVE_SECRET_VAULT_CACERT_FILE=/etc/certs/vault_ca.crt \
    CLOUD_NATIVE_SECRET_KUBERNETES_NAMESPACE=default \
    CLOUD_NATIVE_SECRET_KUBERNETES_SECRET=gluu \
    CLOUD_NATIVE_SECRET_KUBERNETES_USE_KUBE_CONFIG=false

# ===============
# Persistence ENV
# ===============

ENV CLOUD_NATIVE_PERSISTENCE_TYPE=couchbase \
    CLOUD_NATIVE_PERSISTENCE_LDAP_MAPPING=default \
    CLOUD_NATIVE_COUCHBASE_URL=localhost \
    CLOUD_NATIVE_COUCHBASE_USER=admin \
    CLOUD_NATIVE_COUCHBASE_CERT_FILE=/etc/certs/couchbase.crt \
    CLOUD_NATIVE_COUCHBASE_PASSWORD_FILE=/etc/gluu/conf/couchbase_password \
    CLOUD_NATIVE_COUCHBASE_SUPERUSER="" \
    CLOUD_NATIVE_COUCHBASE_SUPERUSER_PASSWORD_FILE=/etc/gluu/conf/couchbase_superuser_password \
    CLOUD_NATIVE_LDAP_URL=localhost:1636

# ===========
# Generic ENV
# ===========

ENV CLOUD_NATIVE_CACHE_TYPE=NATIVE_PERSISTENCE \
    CLOUD_NATIVE_REDIS_URL=localhost:6379 \
    CLOUD_NATIVE_REDIS_TYPE=STANDALONE \
    CLOUD_NATIVE_REDIS_USE_SSL=false \
    CLOUD_NATIVE_REDIS_SSL_TRUSTSTORE="" \
    CLOUD_NATIVE_REDIS_SENTINEL_GROUP="" \
    CLOUD_NATIVE_MEMCACHED_URL=localhost:11211 \
    CLOUD_NATIVE_WAIT_SLEEP_DURATION=10 \
    CLOUD_NATIVE_OXTRUST_API_ENABLED=false \
    CLOUD_NATIVE_OXTRUST_API_TEST_MODE=false \
    CLOUD_NATIVE_CASA_ENABLED=false \
    CLOUD_NATIVE_PASSPORT_ENABLED=false \
    CLOUD_NATIVE_RADIUS_ENABLED=false \
    CLOUD_NATIVE_SAML_ENABLED=false \
    CLOUD_NATIVE_SCIM_ENABLED=false \
    CLOUD_NATIVE_SCIM_TEST_MODE=false \
    CLOUD_NATIVE_PERSISTENCE_SKIP_EXISTING=true \
    CLOUD_NATIVE_DOCUMENT_STORE_TYPE=LOCAL \
    CLOUD_NATIVE_JACKRABBIT_RMI_URL="" \
    CLOUD_NATIVE_JACKRABBIT_URL=http://localhost:8080 \
    CLOUD_NATIVE_JACKRABBIT_ADMIN_ID_FILE=/etc/gluu/conf/jackrabbit_admin_id \
    CLOUD_NATIVE_JACKRABBIT_ADMIN_PASSWORD_FILE=/etc/gluu/conf/jackrabbit_admin_password

# ====
# misc
# ====

LABEL name="Persistence" \
    maintainer="Janssen <support@jans.io>" \
    vendor="Janssen Project" \
    version="5.0.0" \
    release="dev" \
    summary="Janssen Authorization Server Persistence loader" \
    description="Generate initial data for persistence layer"

RUN mkdir -p /app/tmp /etc/certs /etc/gluu/conf

COPY scripts /app/scripts
COPY static /app/static
COPY templates /app/templates
RUN chmod +x /app/scripts/entrypoint.sh

ENTRYPOINT ["tini", "-g", "--"]
CMD ["sh", "/app/scripts/entrypoint.sh"]

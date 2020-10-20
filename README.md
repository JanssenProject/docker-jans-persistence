## Overview

Persistence is a special container to load initial data for LDAP or Couchbase.

## Versions

See [Releases](https://github.com/JanssenProject/docker-jans-persistence/releases) for stable versions.
For bleeding-edge/unstable version, use `janssenproject/persistence:5.0.0_dev`.

## Environment Variables

The following environment variables are supported by the container:

- `CLOUD_NATIVE_CONFIG_ADAPTER`: The config backend adapter, can be `consul` (default) or `kubernetes`.
- `CLOUD_NATIVE_CONFIG_CONSUL_HOST`: hostname or IP of Consul (default to `localhost`).
- `CLOUD_NATIVE_CONFIG_CONSUL_PORT`: port of Consul (default to `8500`).
- `CLOUD_NATIVE_CONFIG_CONSUL_CONSISTENCY`: Consul consistency mode (choose one of `default`, `consistent`, or `stale`). Default to `stale` mode.
- `CLOUD_NATIVE_CONFIG_CONSUL_SCHEME`: supported Consul scheme (`http` or `https`).
- `CLOUD_NATIVE_CONFIG_CONSUL_VERIFY`: whether to verify cert or not (default to `false`).
- `CLOUD_NATIVE_CONFIG_CONSUL_CACERT_FILE`: path to Consul CA cert file (default to `/etc/certs/consul_ca.crt`). This file will be used if it exists and `CLOUD_NATIVE_CONFIG_CONSUL_VERIFY` set to `true`.
- `CLOUD_NATIVE_CONFIG_CONSUL_CERT_FILE`: path to Consul cert file (default to `/etc/certs/consul_client.crt`).
- `CLOUD_NATIVE_CONFIG_CONSUL_KEY_FILE`: path to Consul key file (default to `/etc/certs/consul_client.key`).
- `CLOUD_NATIVE_CONFIG_CONSUL_TOKEN_FILE`: path to file contains ACL token (default to `/etc/certs/consul_token`).
- `CLOUD_NATIVE_CONFIG_KUBERNETES_NAMESPACE`: Kubernetes namespace (default to `default`).
- `CLOUD_NATIVE_CONFIG_KUBERNETES_CONFIGMAP`: Kubernetes configmaps name (default to `janssen`).
- `CLOUD_NATIVE_CONFIG_KUBERNETES_USE_KUBE_CONFIG`: Load credentials from `$HOME/.kube/config`, only useful for non-container environment (default to `false`).
- `CLOUD_NATIVE_SECRET_ADAPTER`: The secrets adapter, can be `vault` or `kubernetes`.
- `CLOUD_NATIVE_SECRET_VAULT_SCHEME`: supported Vault scheme (`http` or `https`).
- `CLOUD_NATIVE_SECRET_VAULT_HOST`: hostname or IP of Vault (default to `localhost`).
- `CLOUD_NATIVE_SECRET_VAULT_PORT`: port of Vault (default to `8200`).
- `CLOUD_NATIVE_SECRET_VAULT_VERIFY`: whether to verify cert or not (default to `false`).
- `CLOUD_NATIVE_SECRET_VAULT_ROLE_ID_FILE`: path to file contains Vault AppRole role ID (default to `/etc/certs/vault_role_id`).
- `CLOUD_NATIVE_SECRET_VAULT_SECRET_ID_FILE`: path to file contains Vault AppRole secret ID (default to `/etc/certs/vault_secret_id`).
- `CLOUD_NATIVE_SECRET_VAULT_CERT_FILE`: path to Vault cert file (default to `/etc/certs/vault_client.crt`).
- `CLOUD_NATIVE_SECRET_VAULT_KEY_FILE`: path to Vault key file (default to `/etc/certs/vault_client.key`).
- `CLOUD_NATIVE_SECRET_VAULT_CACERT_FILE`: path to Vault CA cert file (default to `/etc/certs/vault_ca.crt`). This file will be used if it exists and `CLOUD_NATIVE_SECRET_VAULT_VERIFY` set to `true`.
- `CLOUD_NATIVE_SECRET_KUBERNETES_NAMESPACE`: Kubernetes namespace (default to `default`).
- `CLOUD_NATIVE_SECRET_KUBERNETES_CONFIGMAP`: Kubernetes secrets name (default to `janssen`).
- `CLOUD_NATIVE_SECRET_KUBERNETES_USE_KUBE_CONFIG`: Load credentials from `$HOME/.kube/config`, only useful for non-container environment (default to `false`).
- `CLOUD_NATIVE_WAIT_MAX_TIME`: How long the startup "health checks" should run (default to `300` seconds).
- `CLOUD_NATIVE_WAIT_SLEEP_DURATION`: Delay between startup "health checks" (default to `10` seconds).
- `CLOUD_NATIVE_OXTRUST_CONFIG_GENERATION`: Whether to generate oxShibboleth configuration or not (default to `true`).
- `CLOUD_NATIVE_CACHE_TYPE`: Supported values are `IN_MEMORY`, `REDIS`, `MEMCACHED`, and `NATIVE_PERSISTENCE` (default to `NATIVE_PERSISTENCE`).
- `CLOUD_NATIVE_REDIS_URL`: URL of Redis server, format is host:port (optional; default to `localhost:6379`).
- `CLOUD_NATIVE_REDIS_TYPE`: Redis service type, either `STANDALONE` or `CLUSTER` (optional; default to `STANDALONE`).
- `CLOUD_NATIVE_MEMCACHED_URL`: URL of Memcache server, format is host:port (optional; default to `localhost:11211`).
- `CLOUD_NATIVE_PERSISTENCE_TYPE`: Persistence backend being used (one of `ldap`, `couchbase`, or `hybrid`; default to `ldap`).
- `CLOUD_NATIVE_PERSISTENCE_LDAP_MAPPING`: Specify data that should be saved in LDAP (one of `default`, `user`, `cache`, `site`, `token`, or `session`; default to `default`). Note this environment only takes effect when `CLOUD_NATIVE_PERSISTENCE_TYPE` is set to `hybrid`.
- `CLOUD_NATIVE_PERSISTENCE_SKIP_EXISTING`: skip initialization if backend already initialized (default to `True`).
- `CLOUD_NATIVE_LDAP_URL`: Address and port of LDAP server (default to `localhost:1636`); required if `CLOUD_NATIVE_PERSISTENCE_TYPE` is set to `ldap` or `hybrid`.
- `CLOUD_NATIVE_COUCHBASE_URL`: Address of Couchbase server (default to `localhost`); required if `CLOUD_NATIVE_PERSISTENCE_TYPE` is set to `couchbase` or `hybrid`.
- `CLOUD_NATIVE_COUCHBASE_USER`: Username of Couchbase server (default to `admin`); required if `CLOUD_NATIVE_PERSISTENCE_TYPE` is set to `couchbase` or `hybrid`.
- `CLOUD_NATIVE_COUCHBASE_SUPERUSER`: Superuser of Couchbase server (default to empty-string); required if `CLOUD_NATIVE_PERSISTENCE_TYPE` is set to `couchbase` or `hybrid`. Fallback to `CLOUD_NATIVE_COUCHBASE_USER`.
- `CLOUD_NATIVE_COUCHBASE_CERT_FILE`: Couchbase root certificate location (default to `/etc/certs/couchbase.crt`); required if `CLOUD_NATIVE_PERSISTENCE_TYPE` is set to `couchbase` or `hybrid`.
- `CLOUD_NATIVE_COUCHBASE_PASSWORD_FILE`: Path to file contains Couchbase password (default to `/etc/jans/conf/couchbase_password`); required if `CLOUD_NATIVE_PERSISTENCE_TYPE` is set to `couchbase` or `hybrid`.
- `CLOUD_NATIVE_COUCHBASE_SUPERUSER_PASSWORD_FILE`: Path to file contains Couchbase superuser password (default to `/etc/jans/conf/couchbase_superuser_password`); required if `CLOUD_NATIVE_PERSISTENCE_TYPE` is set to `couchbase` or `hybrid`.
- `CLOUD_NATIVE_OXTRUST_API_ENABLED`: Enable oxTrust API (default to `false`).
- `CLOUD_NATIVE_OXTRUST_API_TEST_MODE`: Enable oxTrust API test mode; not recommended for production (default to `false`). If set to `false`, UMA mode is activated. See [oxTrust API docs](https://gluu.org/docs/oxtrust-api/4.1/) for reference.
- `CLOUD_NATIVE_CASA_ENABLED`: Enable Casa-related features; custom scripts, ACR, UI menu, etc. (default to `false`).
- `CLOUD_NATIVE_PASSPORT_ENABLED`: Enable Passport-related features; custom scripts, ACR, UI menu, etc. (default to `false`).
- `CLOUD_NATIVE_RADIUS_ENABLED`: Enable Radius-related features; UI menu, etc. (default to `false`).
- `CLOUD_NATIVE_SAML_ENABLED`: Enable SAML-related features; UI menu, etc. (default to `false`).
- `CLOUD_NATIVE_DOCUMENT_STORE_TYPE`: Document store type (one of `LOCAL` or `JCA`; default to `LOCAL`).
- `CLOUD_NATIVE_JACKRABBIT_URL`: URL to remote repository (default to `http://localhost:8080`).
- `CLOUD_NATIVE_JACKRABBIT_ADMIN_ID_FILE`: Absolute path to file contains ID for admin user (default to `/etc/jans/conf/jackrabbit_admin_id`).
- `CLOUD_NATIVE_JACKRABBIT_ADMIN_PASSWORD_FILE`: Absolute path to file contains password for admin user (default to `/etc/gluu/conf/jackrabbit_admin_password`).

## Initializing Data

### LDAP

Deploy Wren:DS container:

```sh
docker run -d \
    --network container:consul \
    --name ldap \
    -e CLOUD_NATIVE_CONFIG_ADAPTER=consul \
    -e CLOUD_NATIVE_CONFIG_CONSUL_HOST=consul \
    -e CLOUD_NATIVE_SECRET_ADAPTER=vault \
    -e CLOUD_NATIVE_SECRET_VAULT_HOST=vault \
    -v /path/to/opendj/config:/opt/opendj/config \
    -v /path/to/opendj/db:/opt/opendj/db \
    -v /path/to/opendj/logs:/opt/opendj/logs \
    -v /path/to/opendj/ldif:/opt/opendj/ldif \
    -v /path/to/opendj/backup:/opt/opendj/bak \
    -v /path/to/vault_role_id.txt:/etc/certs/vault_role_id \
    -v /path/to/vault_secret_id.txt:/etc/certs/vault_secret_id \
    gluufederation/opendj:4.2.1_02
```

Run the following command to initialize data and save it to LDAP:

```sh
docker run --rm \
    --network container:consul \
    --name persistence \
    -e CLOUD_NATIVE_CONFIG_ADAPTER=consul \
    -e CLOUD_NATIVE_CONFIG_CONSUL_HOST=consul \
    -e CLOUD_NATIVE_SECRET_ADAPTER=vault \
    -e CLOUD_NATIVE_SECRET_VAULT_HOST=vault \
    -e CLOUD_NATIVE_PERSISTENCE_TYPE=ldap \
    -e CLOUD_NATIVE_LDAP_URL=ldap:1636 \
    -v /path/to/vault_role_id.txt:/etc/certs/vault_role_id \
    -v /path/to/vault_secret_id.txt:/etc/certs/vault_secret_id \
    janssenproject/persistence:5.0.0_dev
```

The process may take awhile, check the output of the `persistence` container log.

### Couchbase

Assuming there is Couchbase instance running hosted at `192.168.100.2` address, setup the cluster:

1. Set the username and password of Couchbase cluster
1. Configure the instance to use Query, Data, and Index services

Once cluster has been configured successfully, do the following steps:

1. Pass the address of Couchbase server in `CLOUD_NATIVE_COUCHBASE_URL` (omit the port)
1. Pass the Couchbase superuser in `CLOUD_NATIVE_COUCHBASE_SUPERUSER`
1. Save the password into `/path/to/couchbase_superuser_password` file
1. Get the certificate root of Couchbase and save it into `/path/to/couchbase.crt` file

Run the following command to initialize data and save it to Couchbase:

```sh
docker run --rm \
    --network container:consul \
    --name persistence \
    -e CLOUD_NATIVE_CONFIG_ADAPTER=consul \
    -e CLOUD_NATIVE_CONFIG_CONSUL_HOST=consul \
    -e CLOUD_NATIVE_SECRET_ADAPTER=vault \
    -e CLOUD_NATIVE_SECRET_VAULT_HOST=vault \
    -e CLOUD_NATIVE_PERSISTENCE_TYPE=couchbase \
    -e CLOUD_NATIVE_COUCHBASE_URL=192.168.100.2 \
    -e CLOUD_NATIVE_COUCHBASE_SUPERUSER=admin \
    -v /path/to/couchbase.crt:/etc/certs/couchbase.crt \
    -v /path/to/couchbase_superuser_password:/etc/jans/conf/couchbase_superuser_password \
    -v /path/to/vault_role_id.txt:/etc/certs/vault_role_id \
    -v /path/to/vault_secret_id.txt:/etc/certs/vault_secret_id \
    janssenproject/persistence:5.0.0_dev
```

The process may take awhile, check the output of the `persistence` container log.

### Hybrid

Hybrid is a mix of LDAP and Couchbase persistence backend. To initialize data for this type of persistence:

1.  Deploy LDAP container:

    ```sh
    docker run -d \
        --network container:consul \
        --name ldap \
        -e CLOUD_NATIVE_CONFIG_ADAPTER=consul \
        -e CLOUD_NATIVE_CONFIG_CONSUL_HOST=consul \
        -e CLOUD_NATIVE_SECRET_ADAPTER=vault \
        -e CLOUD_NATIVE_SECRET_VAULT_HOST=vault \
        -v /path/to/opendj/config:/opt/opendj/config \
        -v /path/to/opendj/db:/opt/opendj/db \
        -v /path/to/opendj/logs:/opt/opendj/logs \
        -v /path/to/opendj/ldif:/opt/opendj/ldif \
        -v /path/to/opendj/backup:/opt/opendj/bak \
        -v /path/to/vault_role_id.txt:/etc/certs/vault_role_id \
        -v /path/to/vault_secret_id.txt:/etc/certs/vault_secret_id \
        gluufederation/opendj:4.2.1_02
    ```

1.  Prepare Couchbase cluster.

    Assuming there is Couchbase instance running hosted at `192.168.100.2` address, setup the cluster:

    1. Set the username and password of Couchbase cluster
    1. Configure the instance to use Query, Data, and Index services

    Once cluster has been configured successfully, do the following steps:

    1. Pass the address of Couchbase server in `CLOUD_NATIVE_COUCHBASE_URL` (omit the port)
    1. Pass the Couchbase user in `CLOUD_NATIVE_COUCHBASE_SUPERUSER`
    1. Save the password into `/path/to/couchbase_superuser_password` file
    1. Get the certificate root of Couchbase and save it into `/path/to/couchbase.crt` file

1.  Determine which data goes to LDAP backend by specifying it using `CLOUD_NATIVE_PERSISTENCE_LDAP_MAPPING` environment variable. For example, if `user` data should be saved into LDAP, set `CLOUD_NATIVE_PERSISTENCE_LDAP_MAPPING=user`. This will make other data saved into Couchbase.

1.  Run the following command to initialize data and save it to LDAP and Couchbase:

    ```sh
    docker run --rm \
        --network container:consul \
        --name persistence \
        -e CLOUD_NATIVE_CONFIG_ADAPTER=consul \
        -e CLOUD_NATIVE_CONFIG_CONSUL_HOST=consul \
        -e CLOUD_NATIVE_SECRET_ADAPTER=vault \
        -e CLOUD_NATIVE_SECRET_VAULT_HOST=vault \
        -e CLOUD_NATIVE_PERSISTENCE_TYPE=hybrid \
        -e CLOUD_NATIVE_PERSISTENCE_LDAP_MAPPING=user \
        -e CLOUD_NATIVE_LDAP_URL=ldap:1636 \
        -e CLOUD_NATIVE_COUCHBASE_URL=192.168.100.2 \
        -e CLOUD_NATIVE_COUCHBASE_SUPERUSER=admin \
        -v /path/to/couchbase.crt:/etc/certs/couchbase.crt \
        -v /path/to/couchbase_superuser_password:/etc/jans/conf/couchbase_superuser_password \
        -v /path/to/vault_role_id.txt:/etc/certs/vault_role_id \
        -v /path/to/vault_secret_id.txt:/etc/certs/vault_secret_id \
        janssenproject/persistence:5.0.0_dev
    ```

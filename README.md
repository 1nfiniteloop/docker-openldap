# openldap

Minimalistic Alpine Linux Docker image for serving an openldap database.

## Configuration

The database will be initialized once during first start, based on the
environment variables found in:

* `/etc/openldap/init/db/*.ldif`
* `/etc/openldap/init/db-config/*.ldif`

The environment variables in ldif files is substituted during init. If any
environment variable is unset (example variables in `01-tls.ldif`) the ldif file
will not be applied.

## Usage

Start ldap service:

    docker run \
      --name openldap \
      --env LDAP_BASE_DN="dc=example,dc=com" \
      --env LDAP_ADMIN_USERNAME="Admin" \
      --env LDAP_ADMIN_PASSWORD="secret" \
      --env LDAP_STORAGE_PATH="/mnt/db" \
      --volume ldap_db:/mnt/db \
      1nfiniteloop/openldap

In case tls certificates is used, a cron job exists to check the expiry of the
certificate. The cron job reloads the certificate file in slapd, asssuming an
external service renew expired certificates (example
https://github.com/1nfiniteloop/docker-pki).

## Development

To validate the default database configuration there is an acceptance test
available in `/root/ldap_test`. To run test:

    docker run --rm 1nfiniteloop/openldap /root/ldap_test

Run test in verbose by setting environment variable `VERBOSE="true"`.

FROM alpine:3.15

RUN apk update \
  && apk add \
    ca-certificates \
    openldap \
    openldap-back-mdb \
    openldap-clients \
    openssl \
  && rm -r /var/cache/apk/* \
  && rm /etc/openldap/*.conf /etc/openldap/*.ldif \
  && mkdir /run/openldap /var/lib/openldap/run \
  && chown ldap:ldap /run/openldap /var/lib/openldap/run

RUN addgroup -g 500 pki \
  && adduser ldap pki

COPY overlay /

ENV LDAP_STORAGE_PATH="/var/lib/openldap/db" \
    LDAP_BASE_DN="dc=example,dc=com" \
    LDAP_ADMIN_PASSWORD="secret"

CMD ["ldap_init", "-h", "ldapi:/// ldap://"]

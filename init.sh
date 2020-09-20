#!/bin/bash
vault login wibble

vault secrets enable database

vault write database/config/postgresql \
    plugin_name=postgresql-database-plugin \
    allowed_roles=readonly \
    connection_url='postgresql://root:rootpassword@postgres:5432/postgres?sslmode=disable'

vault write database/roles/readonly db_name=postgresql \
        creation_statements=@readonly.sql \
        default_ttl=1h max_ttl=24h

vault policy write apps apps-policy.hcl

APPS_TOKEN=$(vault token create -policy="apps" -format=json | jq '.auth.client_token' | xargs)

echo $APPS_TOKEN

VAULT_TOKEN=$APPS_TOKEN vault read database/creds/readonly



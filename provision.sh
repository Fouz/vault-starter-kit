#!/bin/bash
curl -Ls https://releases.hashicorp.com/vault/1.5.3/vault_1.5.3_linux_amd64.zip -o vault.zip
unzip vault.zip
rm vault.zip
chmod a+x vault
sudo mv vault /usr/local/bin

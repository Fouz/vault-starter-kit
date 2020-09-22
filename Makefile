default: vault2

up: network vault postgres

network:
	docker network create lab

vault:
	docker container run --name vault \
		-it -d \
		--network lab \
		--cap-add=IPC_LOCK \
		-e VAULT_DEV_ROOT_TOKEN_ID=wibble \
		-e VAULT_ADDR=http://localhost:8200 \
		-e VAULT_TOKEN=wibble \
		-e VAULT_FORMAT=json \
		-w /work \
		-v $$(pwd):/work \
		-p 8200:8200 \
		vault

vault2:
	docker container run --name vault \
		-it -d \
		--cap-add=IPC_LOCK \
		-e VAULT_DEV_ROOT_TOKEN_ID=wibble \
		-e VAULT_ADDR=http://localhost:8200 \
		-e VAULT_TOKEN=wibble \
		-e VAULT_FORMAT=json \
		-w /work \
		-v $$(pwd):/work \
		-p 8200:8200 \
		vault

postgres:
	docker container run -d \
		--name postgres \
		--network lab \
		-e POSTGRES_USER=root \
		-e POSTGRES_PASSWORD=rootpassword \
		postgres

down:
	docker container rm -f vault
	docker container rm -f postgres
	docker network rm lab

init:
	./init.sh

provision:
	./provision.sh

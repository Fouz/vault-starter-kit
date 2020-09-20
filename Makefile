build:
	docker build -t myvault .

lab:
	docker network create lab
	docker run --name vault \
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
		myvault
	docker run -d \
		--name postgres \
		--network lab \
		-e POSTGRES_USER=root \
		-e POSTGRES_PASSWORD=rootpassword \
		postgres
exec: 
	docker exec -it vault bash

tidy:
	docker rm -f vault
	docker rm -f postgres

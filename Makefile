
.DEFAULT_GOAL := help
.PHONY: up down tailscale ip

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*## "; printf "Usage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

tailscale:  ## Inicia o daemon do Tailscale e conecta na rede
	sudo tailscaled &
	sleep 2
	tailscale up

ip:  ## Exibe o IP e porta para conectar no servidor
	@echo "Conecte em: $$(tailscale ip -4):25565"

up:  ## Sobe o servidor Minecraft via Docker Compose
	docker compose up -d

down:  ## Derruba o servidor Minecraft
	docker compose down

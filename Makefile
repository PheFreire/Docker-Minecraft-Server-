.PHONY: up down tailscale ip

tailscale:
	sudo tailscaled &
	sleep 2
	tailscale up

ip:
	@echo "Conecte em: $$(tailscale ip -4):25565"

up:
	docker compose up -d

down:
	docker compose down

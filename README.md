# Mineserver

Servidor Minecraft Forge 1.20.1 rodando via Docker.

## Requisitos

- Docker + Docker Compose
- Tailscale (para acesso remoto)

## Subindo um servidor do zero

Não é preciso enviar a pasta `data/` para quem for subir um servidor novo. Bastam 3 arquivos:

- `docker-compose.yml`
- `example.env` (copiar para `.env` e ajustar se quiser)
- `rodar.txt` (opcional — script para instalar o Forge e os mods no **cliente** Mac/Linux, para quem for jogar)
- `rodar-windows.txt` (opcional — mesma coisa, mas para **cliente** Windows)

```bash
cp example.env .env
make up
```

A imagem `itzg/minecraft-server` baixa o Forge sozinha na primeira subida, e os mods listados em `MODRINTH_PROJECTS` (no `docker-compose.yml`) são baixados automaticamente para dentro de `data/mods/` — que é criado do zero pelo container. `world/`, `libraries/`, `versions/` e o `.jar` do servidor também são gerados/baixados automaticamente, não precisam ser enviados.

## Makefile

Todos os comandos do dia a dia estão no `Makefile`, na raiz do projeto. Para ver a lista de comandos disponíveis diretamente no terminal, rode:

```bash
make
```

ou

```bash
make help
```

Isso lista todos os targets do Makefile com uma breve descrição de cada um (o próprio `help` é gerado automaticamente a partir dos comentários `##` de cada target, então a lista nunca fica desatualizada).

### Comandos disponíveis

| Comando | O que faz |
|---------|-----------|
| `make help` | Mostra a lista de comandos disponíveis e o que cada um faz. É o target padrão: rodar só `make` (sem argumento) já executa este. |
| `make up` | Sobe o servidor Minecraft via Docker Compose (`docker compose up -d`). Baixa a imagem, o Forge e os mods na primeira vez, e inicia o container em background. |
| `make down` | Derruba o servidor (`docker compose down`), parando e removendo o container. Os dados em `data/` não são apagados. |
| `make tailscale` | Inicia o daemon do Tailscale (`sudo tailscaled &`) e conecta na rede (`tailscale up`). Necessário para permitir acesso remoto ao servidor fora da rede local. |
| `make ip` | Exibe o IP do Tailscale e a porta do servidor (ex: `Conecte em: 100.x.x.x:25565`), que é o endereço que quem for jogar deve usar para conectar. |

## Configuração

Valores em `example.env` (copie para `.env`):

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `MC_VERSION` | `1.20.1` | Versão do Minecraft |
| `FORGE_VERSION` | `47.2.0` | Versão do Forge |
| `MEMORY` | `2G` | Memória alocada |
| `MAX_PLAYERS` | `10` | Máximo de jogadores |
| `SERVER_PORT` | `25565` | Porta do servidor |
| `DIFFICULTY` | `normal` | Dificuldade |
| `MODE` | `survival` | Modo de jogo |
| `ONLINE_MODE` | `true` | Verificação de conta Mojang |

## Mods Instalados

### Otimização
| Mod | Versão | Onde instalar |
|-----|--------|---------------|
| Embeddium | 0.3.31 | Mac + Servidor |
| Canary | 0.3.3 | Mac + Servidor |
| FerriteCore | 6.0.1 | Mac + Servidor |
| ModernFix | 5.27.44 | Mac + Servidor |
| Chunky | 1.3.146 | Apenas Servidor |

### Conteúdo
| Mod | Versão | Onde instalar |
|-----|--------|---------------|
| Create | 0.5.1.j | Mac + Servidor |

## Adicionando Mods

Duas formas:

- **Servidor já rodando:** coloque o `.jar` em `./data/mods/` e reinicie.
- **Para quem sobe do zero:** adicione o ID do mod no Modrinth à variável `MODRINTH_PROJECTS` (dentro de `environment:` no `docker-compose.yml`, separado por vírgula) — o servidor baixa sozinho na próxima subida.

## Primeiro uso / Trocar mapa

Ao adicionar mods que alteram geração de terreno, apague o mundo antes de subir:

```bash
rm -rf ./data/world
make down && make up
```

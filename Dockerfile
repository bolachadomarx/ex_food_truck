# Dockerfile
# Use a imagem base do Elixir
FROM elixir:1.14.5-alpine

# Instale dependências do sistema operacional
RUN apk update && \
    apk add --no-cache build-base git nodejs npm

# Instale Hex + Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Defina o diretório de trabalho dentro do container
WORKDIR /app

# Copie os arquivos do projeto para o container
COPY . .

# Instale dependências do Elixir 
RUN mix deps.get

# Compile a aplicação
RUN mix compile

# Defina o ambiente
ENV MIX_ENV=prod

# Execute as tasks do Phoenix
RUN mix phx.digest

# Exponha a porta que o Phoenix usará
EXPOSE 4000

# Execute o comando para iniciar o Phoenix
CMD ["sh", "-c", "mix ecto.setup && mix phx.server"]
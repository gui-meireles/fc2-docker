# Baixa uma imagem do dockerhub
FROM nginx:latest

# Cria a pasta com o nome abaixo e deixa apontado para ela
WORKDIR /app

# Roda esses comandos ao baixar a imagem ( "&&" executa comandos em sequência, "\" quebra linha )
RUN apt-get update && \
    apt-get install vim -y

COPY html /usr/share/nginx
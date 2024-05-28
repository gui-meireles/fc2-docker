FROM node:15

WORKDIR /usr/src/app

# Como se trata de gerar uma imagem, não conseguimos compartilhar os dados da nossa máquina com o container em real time
# Então copiaremos tudo que estiver dentro da nossa pasta /node na maquina e jogaremos dentro de /usr/src/app no container
# Utilizaremos o . . pois ele copiará tudo que estiver dentro do diretório deste Dockerfile e jogará dentro do WORKDIR /usr/src/app
COPY . .

RUN apt install wget

# Ele vai criar a pasta com os arquivos do node_modules ao buildar o container ao invés de copiar da nossa máquina
RUN npm install express --save

# O comando abaixo do DOCKERIZE obriga com que o container do mysql esteja pronto para depois executar este dockerfile
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Porta para acessar o container
EXPOSE 3000

#CMD ["node","index.js"]
FROM node:15

WORKDIR /usr/src/app

# Como se trata de gerar uma imagem, não conseguimos compartilhar os dados da nossa máquina com o container em real time
# Então copiaremos tudo que estiver dentro da nossa pasta /node na maquina e jogaremos dentro de /usr/src/app no container
# Utilizaremos o . . pois ele copiará tudo que estiver dentro do diretório deste Dockerfile e jogará dentro do WORKDIR /usr/src/app
COPY . .

# Ele vai criar a pasta com os arquivos do node_modules ao buildar o container ao invés de copiar da nossa máquina
RUN npm install express --save

# Porta para acessar o container
EXPOSE 3000

CMD ["node","index.js"]
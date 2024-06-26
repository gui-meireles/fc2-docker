## Primeiros passos com DockerFile

### Comandos úteis

- Remover todos os containers: `docker rm $(docker ps -a -q) -f`.
- Parar todos os containers: `docker stop $(docker ps -a -q)`.
- **Importante:** Caso seja feita alguma alteração no DockerFile, precisamos gerar o `docker
build` para depois executar o `docker run`.

### Executando o Dockerfile do nginx-vim

- Abra um terminal no mesmo diretório do DockerFile em `(fc2-docker/nginx-vim)`.
- Rode o comando: `docker build -t guilhermemmnn/nginx-com-vim:latest .`
> - O `-t` é a tag que será chamada o seu DockerFile.
> - O `.` mostra que o DockerFile está no mesmo diretório.
> - O `guimeireles/nginx-com-vim:latest` indica qual a tag da imagem.

- Para abrir o terminal da imagem : `docker run -it guilhermemmnn/nginx-com-vim bash`

---

### Executando o Dockerfile do ubuntu-cmd

- Abra um terminal no mesmo diretório do DockerFile em `(fc2-docker/ubuntu-cmd)`
- Rode o comando: `docker build -t guilhermemmnn/ubuntu-cmd:latest .`
- Para rodar a imagem : `docker run --rm guilhermemmnn/ubuntu-cmd`

---

### Executando o Dockerfile do docker-hub

- Abra um terminal no mesmo diretório do DockerFile em `(fc2-docker/docker-hub)`
- Rode o comando para criar a imagem: `docker build -t guilhermemmnn/docker-hub:latest .`
- Para rodar a imagem : `docker run --rm -d -p 8080:80 guilhermemmnn/docker-hub`
> - O `--rm` remove automaticamente o container após ele ser encerrado.
> - O `-d` roda o container em modo detached, ou seja, em segundo plano.
> - O `-p` mapeia a porta 8080 da sua máquina com a do container (80)

---

### Publicando imagem no DockerHub

- **Importante** ter criado sua conta no DockerHub.
- Sempre ao buildar uma imagem, coloque o nome do seu usuário do DockerHub, no meu
caso é guilhermemmnn.
- Abra um terminal e digite: `docker login`.
- Adicione o username criado no DockerHub e sua senha.
- Após isso, abra o terminal no diretório do seu DockerFile e digite o comando:
`docker push {seu_username}/{nome_do_repositório}`.

![docker_push.png](readme_images%2Fdocker_push.png)

![docker_hub.png](readme_images%2Fdocker_hub.png)

---

# Networks

Utilizado para fazer a conexão entre containers.

## Trabalhando com bridge (padrão)

- Para criar uma rede: `docker network create --driver bridge {nome_da_rede}`.
- Para baixar um container e subir ele nessa rede criada:
`docker run -dit --name ubuntu1 --network {nome_da_rede} bash`.

_Na imagem abaixo, foi criado 2 containers com nome de `ubuntu1` e `ubuntu2` e rodando
a imagem do bash:_
![docker_bridge.png](readme_images%2Fdocker_bridge.png)

Agora entre no bash em um dos containers, com o comando: `docker exec -it ubuntu1 bash`.

- Ao digitar no bash desse container: `ping ubuntu2` veremos que ele consegue se comunicar
com o outro container, pois estão na mesma rede.

> **Podemos conectar um container que está rodando em outra network, utilizando
o comando:** `docker network connect {nome_da_rede} {nome_do_container}`.
> * E para visualizar os containers da rede, utilize o comando: `docker network inspect {nome_da_rede}`.


## Acessando uma aplicação da sua máquina dentro do container

- Primeiro passo é ter uma aplicação rodando em sua máquina.
- Para fins de teste, usaremos o container do ubuntu: `docker run --rm -it --name ubuntu ubuntu bash`.
- No bash, instale o **curl**: `apt-get update && apt-get install curl -y`.
- Depois, digite: `curl http://host.docker.internal:{porta_aplicação}`.

---

## Criando aplicação node.js

Abaixo vamos criar e executar uma aplicação node.js sem ter o node instalado em nossa máquina.

- Primeiro abra um terminal no diretório do `fc2-docker/node`.
- Digite o comando no linux: `docker run --rm -it -v $(pwd)/:/usr/src/app -p 3000:3000 node:15 bash`.
- Ou no Windows: `docker run --rm -it -v D:/Users/gmeir/Documents/fc2-docker/node/:/usr/src/app -p 3000:3000 node:15 bash`.

> O comando acima remove o container caso não esteja sendo utilizado, abre o bash ao ser executado, mapeia o volume
> na nossa máquina e no container (tudo que estiver em um, estará no outro), mapeia a porta da nossa máquina com o container e sobe a imagem do node v15.

- Após o bash ser carregado, utilize o comando: `cd /usr/src/app`.
- Rode o comando: `npm init` e aperte `Enter` até finalizar, e em seguida rode o comando: `npm install express --save` e
o comando `npm install mysql --save`.
- E você verá que os arquivos serão criados na pasta node da sua máquina.
- Por fim, rodaremos o comando: `node index.js`, que pegará o nosso arquivo `index.js` e subirá com node sem termos 
o node instalado em nossa máquina.
- Para ver o código html rodando, podemos acessar pelo navegador o: `localhost:3000`.

### Subindo node.js com mysql com docker-compose

- Suba o docker-compose.mysql.yaml.
- Abra dois terminais e em cada um digite um dos comandos: `docker exec -it db bash` e `docker exec -it app bash`.
- No terminal do `mysql` rode os comandos na sequência: `mysql -uroot -p`, `root`, `use nodedb`, 
`create table people(id int not null auto_increment, name varchar(255), primary key(id));`.
- Agora no terminal do `app`, rode o comando: `npm install mysql --save` e logo em seguida o: `node index.js`.
- E se você fizer um **select** na tabela de people no mysql, verá que ele criou uma linha com _Guilherme_

### Subindo nosso node.js no DockerHub

- Abra o terminal no diretório do Dockerfile (fc2-docker/node).
- Build a imagem com o comando: `docker build -t {usuario_dockerhub}/{nome_da_imagem} .`
- Suba a imagem no dockerhub com o comando: `docker push {usuario_dockerhub}/{nome_da_imagem}`.

> O nome da imagem pode ser qualquer um, fica ao seu critério.

---

## Otimizando com Multistage Building

Para otimizar nossos containers, podemos utilizar o Multistage Building.

No arquivo que está em `php/Dockerfile.prod` utilizamos essa função para reduzir drasticamente
o tamanho do nosso container, e consequentemente deixa-lo mais rápido.

> Para executar o Dockerfile com outro nome, abriremos um terminal na raiz do projeto
> (fc2-docker) e utilizamos o comando: `docker build -t guilhermemmnn/php.prod php -f php/Dockerfile.prod`.
> <br> Sendo que, `guilhermemmnn/php.prod` é tag do container e
> <br> `php -f php/Dockerfile.prod` é onde o arquivo se encontra.

---

### Utilizando nginx com php

- Abra um terminal no diretório `fc2-docker/nginx`.
- Rode o comando `docker build -t guilhermemmnn/nginx:prod . -f Dockerfile.prod`.
- E vamos criar uma network para os containers se comunicarem: `docker network create laranet`.
- Agora, lembre de ter buildado o `Dockerfile.prod` que está em `fc2-docker/php`.
- E rodar nossa imagem na network: `docker run -d --network laranet --name laravel guilhermemmnn/laravel:prod`.
- Agora vamos subir nosso nginx na nossa rede: `docker run -d --network laranet --name nginx -p 8080:80 guilhermemmnn/nginx:prod`.
- Se você rodar um docker ps, você verá os seguintes containers rodando:

![docker_ps.png](readme_images%2Fdocker_ps.png)
> Com isso, ao acessarmos o link: `localhost:8080` no navegador, o nginx chamará o laravel/php que está na porta 9000
e vai nos devolver a resposta pela porta `8080`.

---
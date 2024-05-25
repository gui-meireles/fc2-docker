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
- Rode o comando: `npm init`, e em seguida o: `npm install express --save`.
- E você verá que os arquivos serão criados na pasta node da sua máquina.
- Por fim, rodaremos o comando: `node index.js`, que pegará o nosso arquivo `index.js` e subirá com node sem termos 
o node instalado em nossa máquina.
- Para ver o código html rodando, podemos acessar pelo navegador o: `localhost:3000`.

---
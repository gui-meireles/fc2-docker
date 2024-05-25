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
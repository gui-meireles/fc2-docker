## Primeiros passos com DockerFile

### Comandos úteis

- Remover todos os containers: `docker rm $(docker ps -a -q) -f`.
- Parar todos os containers: `docker stop $(docker ps -a -q)`.
- **Importante:** Caso seja feita alguma alteração no DockerFile, precisamos gerar o `docker
build` para depois executar o `docker run`.

### Executando o Dockerfile do nginx

- Abra um terminal no mesmo diretório do DockerFile em `(fc2-docker\nginx-vim)`.
- Rode o comando: `docker build -t guilhermemmnn/nginx-com-vim:latest .`
> - O `-t` é a tag que será chamada o seu DockerFile.
> - O `.` mostra que o DockerFile está no mesmo diretório.
> - O `guimeireles/nginx-com-vim:latest` indica qual a tag da imagem.

- Para abrir o terminal da imagem : `docker run -it guilhermemmnn/nginx-com-vim bash`

---

### Executando o Dockerfile do ubuntu-cmd

- Abra um terminal no mesmo diretório do DockerFile em `(fc2-docker\ubuntu-cmd)`
- Rode o comando: `docker build -t guilhermemmnn/hello:latest .`
- Para rodar a imagem : `docker run --rm guilhermemmnn/hello`


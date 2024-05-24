# Baixa uma imagem do dockerhub
FROM ubuntu:latest

# Executa uma ação no console ( imprime um 'Hello' ), porém ele é um comando imutável
ENTRYPOINT [ "echo", "Hello"]

# Executa uma ação no console ( imprime um 'World' ), porém conseguimos alterar o "World", caso rode o comando 'docker run --rm guilhermemmnn/hello Guilherme'
# Como já colocamos um "echo" no ENTRYPOINT, não precisamos reescreve-lo abaixo
CMD [ "World" ]
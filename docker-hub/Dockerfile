FROM nginx:latest

# Vai copiar o conteúdo da pasta html e colar nesse diretório dentro da imagem do nginx
COPY html /usr/share/nginx/html

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
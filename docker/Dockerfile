FROM node:12.14

RUN npm install -g npm-check
RUN npm install -g karma-cli

WORKDIR /var/www/vue-editorjs

VOLUME /var/www/vue-editorjs

# server
EXPOSE 8080

# karma
EXPOSE 9876

USER node

CMD ["node"]

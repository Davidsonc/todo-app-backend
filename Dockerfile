# Build
FROM node:18-alpine as build

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY package*.json ./
RUN npm ci --silent
COPY . ./

# Install TypeScript globally
RUN npm install -g typescript

# Compile TypeScript code
RUN npm run build

# Server
FROM node:18-alpine

WORKDIR /app

# Copie os arquivos necessários do estágio de construção
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package*.json ./
COPY --from=build /app/build ./
COPY --from=build /app/prisma/schema.prisma ./prisma/
COPY --from=build /app/prisma/migrations/ ./prisma/

# Copie o script de ponto de entrada e configure as permissões
COPY --from=build /app/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Desative as notificações de atualização do npm
RUN npm config set update-notifier false

# Configure o ponto de entrada e a porta de exposição
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 5000

# Comando padrão para iniciar o servidor
CMD ["npm", "start"]

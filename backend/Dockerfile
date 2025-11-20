 # syntax=docker/dockerfile:1

 FROM node:20-alpine
 WORKDIR /usr/src/app

 ENV NODE_ENV=production

 COPY package*.json ./
 RUN npm ci --omit=dev

 COPY . .

EXPOSE 2000
 CMD ["node", "src/index.js"]


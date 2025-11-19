 # syntax=docker/dockerfile:1

 FROM node:20-alpine AS deps
 WORKDIR /app
 COPY package*.json ./
 RUN npm ci

FROM deps AS build
ARG VITE_API_URL=http://localhost:2000/api
ENV VITE_API_URL=$VITE_API_URL
 COPY . .
 RUN npm run build

 FROM nginx:1.27-alpine AS runner
 COPY --from=build /app/dist /usr/share/nginx/html
 EXPOSE 80
 CMD ["nginx", "-g", "daemon off;"]

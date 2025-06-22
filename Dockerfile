FROM node:16-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build


FROM node:16-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY src/server ./src/server

COPY --from=builder /app/static ./static

EXPOSE 3000

CMD [ "node", "src/server/app.js" ]
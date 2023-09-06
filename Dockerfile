FROM node:16-alpine as build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm i
COPY . .
RUN npm run build

FROM node:16-alpine As production
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY package*.json ./

RUN npm i --omit=dev
COPY . .

COPY --from=build /usr/src/app/dist ./dist
EXPOSE 3000

CMD ["node", "dist/main"]
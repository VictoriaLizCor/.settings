FROM node:20-alpine

RUN apk update && apk add sqlite

# Create app directory
# WORKDIR /app
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install --include=dev

COPY . .

EXPOSE 3000

CMD ["npm", "run", "dev"]
# CMD ["npm", "start"]

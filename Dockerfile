FROM node:20-alpine
RUN apk add --no-cache openssl
RUN npm install -g nsecbunkerd@latest
CMD ["nsecbunkerd"]

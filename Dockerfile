FROM node:20-alpine
RUN apk add --no-cache openssl
RUN npm install -g nsecbunkerd@0.5.1
CMD ["nsecbunkerd"]

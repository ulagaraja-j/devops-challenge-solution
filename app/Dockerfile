FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app /app
USER node
EXPOSE 5000
CMD ["node", "server.js"]

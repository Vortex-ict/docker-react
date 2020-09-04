# FROM node:alpine as builder
FROM node:alpine
WORKDIR '/app'
# COPY package.json .
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# EXPOSE port 80 toevoegen voor Elastic BeanStalk om de docker te koppelen aan het ELB netwerk.
EXPOSE 80 
# COPY --from=builder /app/build /usr/share/nginx/html
COPY --from=0 /app/build /usr/share/nginx/html

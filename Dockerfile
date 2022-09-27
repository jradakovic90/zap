FROM node:16.14.0 as node
WORKDIR /app
COPY package.json /app/
RUN npm install
COPY ./ /app/
RUN npm run build --prod

FROM nginx:latest
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
RUN rm -rf /usr/share/nginx/html/* 
COPY --from=node app/dist  /usr/share/nginx/html
EXPOSE 80
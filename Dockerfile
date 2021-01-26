FROM node:lts-buster as nodebuild
WORKDIR /build/
COPY . /build/
RUN npm install -g brunch
RUN brunch new -s es6
RUN brunch build --production
FROM nginx
COPY --from=nodebuild /build/public /usr/share/nginx/html/

#Con yarn
#COPY package.json yarn.lock /build/
#RUN yarn
#COPY ./ /build/
#RUN yarn build
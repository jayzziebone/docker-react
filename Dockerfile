# BUILD PHASE that will only serve to build our app. We specify "as" and give the stage a name to use later.
# We used the first phase to build our app then copy the file in the nginx container that will serve our content
FROM node:lts-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# RUN PHASE

FROM nginx
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
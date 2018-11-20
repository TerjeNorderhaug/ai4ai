# docker build -t healthchainhack-base-solution .
# docker run healthchainhack-base-solution -p 8545:8545 -p 8080:8080

## consider 6-alpine instead
FROM node:6

MAINTAINER Terje Norderhaug <terje@in-progress.com>

# RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
# RUN nvm alias default v6
RUN node -v

ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /wait-for-it
RUN chmod +x /wait-for-it 

RUN mkdir /code
WORKDIR /code

COPY ./ .

# avoid rebuilds
RUN rm -rf .git Dockerfile docker-compose.yml  
RUN rm -rf node_modules

RUN npm install -g truffle
# RUN truffle unbox webpack

# In case we want to run ganache-cli in the same container (6.1.0-beta.4 required for node6):
# RUN npm install -g ganache-cli@6.1.0-beta.4

RUN npm install js-sha256
RUN npm install eth-crypto -save
RUN npm install eth-ecies

RUN npm install

RUN truffle compile

# EXPOSE 8545
# EXPOSE 9545
EXPOSE 8080

# --host 0.0.0.0

# ENTRYPOINT ganache-cli & /wait-for-it localhost:8545 -- sh -c "truffle migrate; npm run dev"

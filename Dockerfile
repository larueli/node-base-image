ARG NODE_VERSION=18

FROM node:${NODE_VERSION} AS base

EXPOSE 3000

LABEL maintainer="ivann.laruelle@gmail.com"
COPY entrypoint.sh /entrypoint.sh
ARG DOCKER_COMPOSE_WAIT_VERSION=2.12.1
ENV DOCKER_COMPOSE_WAIT_VERSION=${DOCKER_COMPOSE_WAIT_VERSION}
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/${DOCKER_COMPOSE_WAIT_VERSION}/wait /usr/local/bin/wait-hosts

RUN chmod +x /usr/local/bin/wait-hosts && \
    chmod +x /entrypoint.sh && \
    #npm update -g && \
    npm install -g pnpm && \
    apt update && \
    apt install -y vim zip wget iputils-ping netcat-traditional dnsutils curl unzip git rsync dos2unix nano && \
    apt clean

USER node

ENV NODE_VERSION=${NODE_VERSION}

WORKDIR /app

CMD ["pnpm", "run", "dev"]

ENTRYPOINT [ "/entrypoint.sh" ]

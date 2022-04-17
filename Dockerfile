FROM elixir:alpine AS build
ARG app_name=crypto_api
ENV MIX_ENV=prod REPLACE_OS_VARS=true TERM=xterm
WORKDIR /opt/app
RUN apk add build-base
RUN apk update \
    && mix local.rebar --force \
    && mix local.hex --force
COPY . .
RUN mix do deps.get, deps.compile, compile
RUN mix release \
    && mv _build/prod/rel/${app_name} /opt/release \
    && mv /opt/release/bin/${app_name} /opt/release/bin/start_server

RUN apk update \
    && apk --no-cache --update add bash ca-certificates openssl-dev

ENV PORT=4000 MIX_ENV=prod REPLACE_OS_VARS=true
WORKDIR /opt/app

EXPOSE 4000

CMD /opt/release/bin/start_server start
FROM elixir:1.13

ARG PHOENIX_VERSION=1.6.11
ARG NODEJS_VERSION=16.x

RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y apt-utils
RUN apt-get install -y build-essential
RUN apt-get install -y inotify-tools

RUN curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION} | bash
RUN apt-get install -y nodejs

RUN mix local.hex --force
RUN mix archive.install --force hex phx_new #{PHOENIX_VERSION}
RUN mix local.rebar --force

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

EXPOSE 4000

CMD ["mix", "phx.server"]

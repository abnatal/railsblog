FROM ruby:3.1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs yarn

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY ./railsblog/ .

RUN bundle config --global frozen 1
RUN bundle config set --local without 'development test'
RUN bundle install

RUN yarn install
RUN yarn build
RUN yarn build:css

RUN rails assets:precompile
RUN rails db:migrate

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

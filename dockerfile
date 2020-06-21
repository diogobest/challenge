FROM ruby:2.6.4
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends vim nodejs postgresql-client \
      locales yarn

RUN mkdir /challenge
WORKDIR /challenge
COPY Gemfile /challenge/Gemfile
COPY Gemfile.lock /challenge/Gemfile.lock
RUN bundle install
RUN yarn install
COPY . /challenge

# Start the main process.
# CMD ["rails", "server", "-b", "0.0.0.0"]

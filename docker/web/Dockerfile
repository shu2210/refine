FROM ruby:2.6.3

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       npm

RUN npm install --global yarn
RUN mkdir /app
ENV APP_ROOT /app
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN gem install bundler -v '2.0.2'
RUN bundle install
ADD . $APP_ROOT

ENV DB_HOST_NAME db
ENV DB_USER_NAME root
ENV DB_PASSWORD password

RUN echo "alias dbreset='bundle exec rake db:migrate:reset && bundle exec rake db:seed && bundle exec rake db:migrate:reset RAILS_ENV=test && bundle exec rake db:seed RAILS_ENV=test'" >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

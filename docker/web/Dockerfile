FROM ruby:2.6.3

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       npm \
                       vim \
                       less

RUN npm install --global yarn

ENV DB_HOST_NAME="db" \
    DB_USER_NAME="root" \
    DB_PASSWORD="password" \
    S3_BUCKETNAME="refine-development" \
    APP_ROOT="/app"

RUN mkdir $APP_ROOT

WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock
COPY ./docker/web/.pryrc /root/.pryrc

RUN gem install bundler -v '2.0.2'
RUN bundle install

RUN echo "alias dbreset='bundle exec rake db:migrate:reset && bundle exec rake db:seed && bundle exec rake db:migrate:reset RAILS_ENV=test && bundle exec rake db:seed RAILS_ENV=test'" >> ~/.bashrc
RUN echo "alias dbsetup='bundle exec rake db:migrate && bundle exec rake db:seed && bundle exec rake db:migrate RAILS_ENV=test && bundle exec rake db:seed RAILS_ENV=test'" >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

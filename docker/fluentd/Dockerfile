FROM fluent/fluentd:v1.3.2-1.0

COPY docker/fluentd/fluent.conf /fluentd/etc/fluent.conf

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache \
      ruby-dev \
      make \
      gcc \
      libc-dev

RUN fluent-gem install fluent-plugin-mongo

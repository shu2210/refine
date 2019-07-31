FROM fluent/fluentd:v1.3.2-1.0

COPY docker/fluentd/fluent.conf /fluentd/etc/
RUN gem install fluent-plugin-elasticsearch

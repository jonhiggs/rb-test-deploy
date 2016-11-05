FROM ruby:2.3.1-alpine

RUN apk add --update libxml2 libxml2-dev  gcc g++ make \
  && rm -rf /var/cache/apk/*

ADD /app ./app
WORKDIR /app

RUN bundle install --without development

ENV OUTPUT_DIR /tmp/html
RUN mkdir -p /tmp/html
VOLUME /tmp/html

ENTRYPOINT [ "/usr/local/bin/rake" ]
CMD ["-T"]

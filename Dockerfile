FROM ruby:2.3.1-alpine

ENV OUTPUT_DIR /tmp/html

ADD /app ./app
WORKDIR /app

RUN apk add --update libxml2 libxml2-dev  gcc g++ make \
  && rm -rf /var/cache/apk/*

RUN mkdir -p ${OUTPUT_DIR}
RUN bundle install --without development

ENTRYPOINT [ "/usr/local/bin/rake" ]
CMD ["-t"]

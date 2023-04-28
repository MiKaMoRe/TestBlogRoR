FROM --platform=linux/amd64 ruby:3.1.2-alpine

RUN apk add --update \
  build-base \
  postgresql-dev \
  postgresql-contrib \
  nodejs \
  yarn \
  tzdata \
  && rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app/

ENV BUNDLE_PATH /gems
RUN yarn install
RUN bundle install

ENTRYPOINT [ "bin/rails"]
CMD [ "s", "-b", "0.0.0.0" ]

EXPOSE 3000

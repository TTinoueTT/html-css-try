# ベースとなるイメージの指定（rubyのバージョン3.0.3を指定）
FROM ruby:3.2.2-alpine3.17 as builder

ENV ROOT="/var/www"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR "${ROOT}/rails"

COPY Gemfile Gemfile.lock ${ROOT}

RUN apk add \
    alpine-sdk \
    build-base \
    sqlite-dev \
    mysql-client \
    mysql-dev \
    tzdata \
    git

RUN gem install bundler
RUN bundle install

# ② のマルチステージビルド
FROM ruby:3.2.2-alpine3.17

ENV ROOT="/var/www"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

RUN apk update && \
    apk add \
    mysql-dev \
    tzdata \
    bash

WORKDIR ${ROOT}

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . ${ROOT}
COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
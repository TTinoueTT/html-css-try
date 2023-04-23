# ① bundle install をするためのビルド
# ベースとなるイメージの指定（rubyのバージョン3.0.3を指定）
FROM ruby:3.2.2-alpine3.17 as builder

ENV ROOT="/var/www"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR "${ROOT}/html-css-try"

COPY Gemfile Gemfile.lock ${WORKDIR}

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

# ② のマルチステージビルド 最初のビルドの時は、
# これ以降のコードをコメントアウト
#

# FROM ruby:3.2.2-alpine3.17

# ENV ROOT="/var/www"
# ENV LANG=C.UTF-8
# ENV TZ=Asia/Tokyo

# RUN apk update && \
#     apk add \
#     mysql-dev \
#     tzdata \
#     bash

# WORKDIR "${ROOT}/html-css-try"

# COPY --from=builder /usr/local/bundle /usr/local/bundle
# COPY . ${ROOT}
# COPY entrypoint.sh /usr/bin/

# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

# CMD ["rails", "server", "-b", "0.0.0.0"]
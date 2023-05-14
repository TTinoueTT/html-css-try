# html_css_try
Practice repository for HTML and CSS experimentation.
## 内容
> 基本的なことは
- HTMLの実践
- CSSの実践
- それに付随するアニメーションの実践

## おすすめの実践内容


## dockerコンテナのビルドについて
>
`docker compose build --no-cache`

### rails API の作成
#### rails new
> rails new は皆さんは実際には行わないです
> しかし、このプロジェクトが作られた時以下のコマンドを実行して,
> rails プロジェクトを作成したことを知っておいてください。
`docker compose run --rm api rails new . -f -B --api -d mysql`

`rails new . -f -B --api`
> このコマンドの説明
- `rails new .` には、プロジェクト名を引数にとり、その中にプロジェクトを生成するが、すでに今回作った api ディレクトリにプロジェクトを作る場合、`.`でカレントディレクトリに Rails アプリを作成する
- `-f` はファイルが存在する場合に上書きする、すでにあるGemfileが対象となる
- `-B` は `bundle install` を実行しない
- ここでは実行していないが、`-d データベース名`、例えば、`-d postgresql`などで使用するDBシステムを指定できる、デフォルトが `sqlite3`
- `--api` で、API専用のRailsアプリケーションを作成する
<!-- - `-G` は、.gitignoreの生成をなくす -->

> コマンドを実行することで、Gemfile が Rails専用に書き換わる
#### --api オプションについて
[Rails による API 専用アプリケーション](https://railsguides.jp/api_app.html)
> `ApplicationController` が通常の `ActionController::Base` ではなく、`AcrionController::API` を継承する
> ビュー、ヘルパー、アセットを生成しないようにジェネレータを設定している

#### Gemfile の更新を確認/ Dockerイメージを再ビルド
> `rails new` により、Gemfile が書き換わる
> その為、再度イメージの再ビルドを行う `docker compose build api`

#### アプリの起動を確認
> コンテナを起動させて、ブラウザでの接続を確認
`docker compose up api` => .env に書かれているポートでプラウザでの実行状態を確認(mysql のコネクションエラーであれば大丈夫)

#### DBコンテナへの接続
> apiコンテナにDBに必要な値を、環境変数から渡す
> database.yml を mysqlコンテナに接続できるように書き換え

> そして、この設定でコンテナを再度起動
`docker compose run --rm api rails db:create`


### front ディレクトリに nuxt.js のプロジェクトを作成する
> こちらも皆さんが実際には行わないものですが、nuxt.jsをインストールするまでの流れを確認しておいてください。
> 先に、docker build でイメージを作成していることが前提で進みます

```sh:コンテナ起動
# docker compose run --rm front npx nuxi init app

docker compose run --rm front pnpm dlx nuxi init app
# package.json で nuxt のバージョンを 3.2 にする
docker compose run --rm front sh -c "cd nuxt-app && pnpm install"

# コンテナ起動 nuxt.js のプロジェクト作成、
# デフォルトでnuxt-app ディレクトリ配下にプロジェクトの中身が作られる
# 明示的に ディレクトリ名を作成する(後ほど、このプロジェクト名ディレクトリの外に出す)

mv front/app/{*,.*} front
rmdir front/app

# package.json で以下を指定
# "@types/node": "18.11.9",
# "nuxt": "^3.4.1"

docker compose run --rm front pnpm install

docker compose up front

# でコンテナが起動されて、nuxtの起動できているか http://localhost:8030/ で動いているか確認する
```

## git のサブモジュール管理
### git管理の全体像
```:ディレクトリ階層の図
html_css_try
    │
    ├ /api
    │
    └ /front
```
Gitリポジトリを3つ用意して、それぞれは以下の役割とする
1. root リポジトリ  …作業フォルダ直下のファイルを管理
2. api リポジトリ   … Railsアプリを管理
3. front リポジトリ … Nuxt.jsアプリを管理

> root リポジトリが html_css_try の直下のファイルを管理して、その配下の /api、/front
> のディレクトリを api リポジトリ、 front リポジトリとして別で管理する
> この２つのリポジトリをサブモジュールとして、rootリポジトリで管理する

### サブモジュールとして管理
サブモジュール …別プロジェクトの変更(コミット)をメインのプロジェクトに紐づけるGit機能の一つ
> 手順
① api ディレクトリの変更を、apiリポジトリにコミットする
② そのメインリポジトリである、root リポジトリでも api ディレクトリのコミットを受けて、コミットする

api と front をモジュールとして、管理してrootで運用していく
リポジトリが独立していて変更を各ディレクトリでコミットしておく

### サブモジュールを作成していく手順
1. rootリポジトリ、apiリポジトリ、frontリポジトリをあらかじめ github で作成
2. root階層で `git submodule add https://github.com/TTinoueTT/html-css-try-api.git api` のようにしてサブモジュールを api ディレクトリにクローンする
3. 同様に frot もクローンする
4. 各サブモジュールでブランチと、リモートブランチの設定を行う

> ブランチの設定
- サブモジュールのディレクトリで既存のmainブランチを更新する `git branch -M main main-api` や `git branch -M main main-front`
- `git remote -v` でリモートブランチの設定値を確認、例えば、gitアカウントを複数管理している場合は
    `git remote set-url リモート名 変更したいURL`で指定のURLで登録を行う
    `git remote set-url origin git@my-private-github:TTinoueTT/html-css-try-front.git`のようにして

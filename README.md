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

### rails new
> rails new は皆さんは実際には行わないです
> しかし、このプロジェクトが作られた時以下のコマンドを実行して,
> rails プロジェクトを作成したことを知っておいてください。
`docker compose run --rm api rails new . -f -B --api`

`rails new . -f -B --api`
> このコマンドの説明
- `rails new .` には、プロジェクト名を引数にとり、その中にプロジェクトを生成するが、すでに今回作った api ディレクトリにプロジェクトを作る場合、`.`でカレントディレクトリに Rails アプリを作成する
- `-f` はファイルが存在する場合に上書きする、すでにあるGemfileが対象となる
- `-B` は `bundle install` を実行しない
- ここでは実行していないが、`-d データベース名`、例えば、`-d postgresql`などで使用するDBシステムを指定できる、デフォルトが `sqlite3`
- `--api` で、API専用のRailsアプリケーションを作成する

> コマンドを実行することで、Gemfile が Rails専用に書き換わる
#### --api オプションについて
[Rails による API 専用アプリケーション](https://railsguides.jp/api_app.html)
> `ApplicationController` が通常の `ActionController::Base` ではなく、`AcrionController::API` を継承する
> ビュー、ヘルパー、アセットを生成しないようにジェネレータを設定している

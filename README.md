# アプリ名 name
* 文字る

# 概要 Description
* 文字を作ってシェア出来る投稿サイト
* 言葉、意味、例文、それに関してのイメージを含む投稿

# 使用技術
* Haml
* Saas
* Git(GitHub)
* Ruby
* Ruby on Rails
* JavaScript
* AWS(EC2)
* RSpec

# 環境条件 Requirement/gem
* Ruby'2.6.5'
* Rails'~> 6.0.0'

# 説明 Features
## 基礎機能
* haml/SASS記法と、命名規則BEMを使ったマークアップ
* ログイン
* 投稿機能
* 投稿閲覧機能
* 投稿編集/消去機能
## 追加機能
* 投稿検索機能
* ユーザー検索機能
* SNS認証による新規登録
* twitterシェア機能
* 閲覧数取得機能
* 閲覧数順表示機能
* いいね機能
* いいね順表示機能
* ページネーション機能(bootstrap)
* コメント機能
* タグ機能
* フォロー機能
* フォロワー/フォロー表示機能
* 投稿詳細ページの前と次の詳細ページへ遷移のリンク付け
* RSpecを使った単体テスト


# 本番環境
* 本番環境のIPアドレス
  http://54.95.247.118/
* テスト用ログイン情報
- email :aaa@aaa.com
- password :aaaaaa

# 課題や今後実装したい機能
* いいね/コメント/投稿消去,検索などの非同期化
* プレビュー機能
* タイムライン機能
* 通知機能
* admin機能
* 問い合わせ機能
* 動画投稿機能
* パスワードリセット機能
* dockerでの環境構築
* レスポンシブデザイン

# フリマ DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|image|text|null:false|
|email|string|null: false|
|password|string|null: false|

### Association
- has_many :posts
- has_many :comments
- has_many :likes
- has_many :liked_posts
- has_many :sns_credentials
- has_many :follower
- has_many :followed
- has_many :following_user
- has_many :follower_user
## postsテーブル
|Column|Type|Options|
|------|----|-------|
|vocab|string|null: false|
|definition|text|null: false|
|example|text|null: false|
|image|text|null:false|
|user_id|integer|null: false|
|impressions_count|integer|

### Association
- belongs_to :user
- has_many :comments
- has_many :images
- belongs_to :category
- has_many :likes
- has_many :liked_users,

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false|
|post|references|null: false|


### Association
- belongs_to :user
- belongs_to :post

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user|references|null: false, foreign_key: true|
|post|references|null: false, foreign_key: true|

### Association
- belongs_to :post
- belongs_to :user

## relationshipsテーブル
|Column|Type|Options|
|------|----|-------|
|follower|references|null: false, foreign_key: true|
|follwed|references|null: false, foreign_key: true|

### Association
- belongs_to :follower
- belongs_to :followed

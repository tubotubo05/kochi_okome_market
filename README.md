# README

# kochi_okome_market DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|index: true|
|password|string|null: false|
### Association
- has_one :profiles, dependent: :destroy
- has_many :destinations, dependent: :destroy
- has_many :credit_cards, dependent: :destroy
- has_many :items, dependent: :destroy
## profilesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|kana_first_name|string|null: false|
|kana_last_name|string|null: false|
|birthday|date|null: false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
## destinationsテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|kana_first_name|string|null: false|
|kana_last_name|string|null: false|
|postal_code|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|additional_information|string||
|phone_number|string||
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture
## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|customer_token|string|null: false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|description|text|null: false|
|prefecture_id|integer|null: false|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|foreign_key: true|
|condition_id|integer|null: false|
|shipping_id|integer|null: false|
|shipping_day_id|integer|null: false|
|buyer_id|references|foreign_key: true|
|user_id|references|null: false, foreign_key: true|
### Association
- has_many :item_images, dependent :destroy
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :condition
- belongs_to_active_hash :shipping
- belongs_to_active_hash :shipping_day
## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image_url|string|null: false|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :item
## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||
### Association
- has_many :items
- has_ancestry
## Brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items

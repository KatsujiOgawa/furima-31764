# テーブル設計

## users テーブル

| Column                 | Type   | Options     |
| -----------------------| ------ | ----------- |
| nickname               | string | null: false |
| email                  | string | null: false |
| password               | string | null: false |
| first_name             | string | null: false |
| last_name              | string | null: false |
| first_name_katakana    | string | null: false |
| last_name_katakana     | string | null: false |

### Association

- has_many :items
- has_many :buys

## items テーブル

| Column       | Type               | Options     |
| ------------ | ------------------ | ----------- |
| name         | text               | null: false |
| info         | text               | null: false |
| price        | integer            | null: false |
| image        | ActiveStorageで実装 | ----------- |
| category     | string             | null: false |
| condition    | string             | null: false |
| user         | references         | null: false |


### Association

- has_one :buy
- belongs_to :user

## buys テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| item       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item


## shipments テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | integer    | null: false                    |
| prefecture    | string     | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     | ------------------------------ |
| phone_number  | integer    | null: false                    |
| buy           | references | null: false, foreign_key: true |

### Association

- belongs_to :buy
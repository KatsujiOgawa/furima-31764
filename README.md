# テーブル設計

## users テーブル

| Column                 | Type    | Options     |
| -----------------------| ------- | ----------- |
| nickname               | string  | null: false |
| email                  | string  | null: false |
| encrypted_password     | string  | null: false |
| first_name             | string  | null: false |
| last_name              | string  | null: false |
| first_name_katakana    | string  | null: false |
| last_name_katakana     | string  | null: false |
| year_of_birth_id       | integer | null: false |
| month_of_birth_id      | integer | null: false |
| day_of_birth_id        | integer | null: false |

### Association

- has_many :items
- has_many :buys

## items テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name         | string     | null: false                    |
| info         | text       | null: false                    |
| price        | integer    | null: false                    |
| category_id  | integer    | null: false                    |
| condition_id | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |


### Association

- has_one :buy
- belongs_to :user

## buys テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| item        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :shipment


## shipments テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     | ------------------------------ |
| phone_number  | string     | null: false                    |
| buy           | references | null: false, foreign_key: true |

### Association

- belongs_to :buy
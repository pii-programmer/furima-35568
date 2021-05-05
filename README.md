# テーブル設計

## usersテーブル
| Column          | Type    | Options        | 
| --------------- | ------- | -------------- |
| nickname        | string  | null: false    |
| email           | string  | null: false    |
| password        | string  | null: false    |
| last_name       | string  | null: false    |
| first_name      | string  | null: false    |
| last_name_kana  | string  | null: false    |
| first_name_kana | string  | null: false    |
| birth_date      | integer | null: false    |

### Association
has_many :items
has_many :comments

## itemsテーブル
| Column              | Type          | Options        | 
| ------------------- | ------------- | -------------- |
| name                | string        | null: false    |
| image               | ActiveStrageで実装              |
| text                | text          | null: false    |
| category            | string        | null: false    |
| status              | string        | null: false    |
| shipping_fee        | string        | null: false    |
| prefecture          | string        | null: false    |
| schedule_delivery   | string        | null: false    |
| price               | integer       | null: false    |
| user_id             | references    |                |

### Association
has_one :order
has_many :comments

## ordersテーブル
| Column       | Type          | Options        | 
| ------------ | ------------- | -------------- |
| card_number  | integer       | null: false    |
| exp_month    | integer       | null: false    |
| exp_year     | integer       | null: false    |
| cvc          | integer       | null: false    |
| postal_cord  | integer       | null: false    |
| prefecture   | string        | null: false    |
| city         | string        | null: false    |
| address      | string        | null: false    |
| building     | string        |                |
| phone_number | integer       | null: false    |
| item_id      | references    |                |

### Association
belongs_to :item

## commentsテーブル
| Column     | Type       | Options        | 
| ---------- | ---------- | -------------- |
| text       | text       | null: false    |
| user_id    | references |                |
| item_id    | references |                |

### Association
belongs_to :user
belongs_to :item
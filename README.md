# テーブル設計

## usersテーブル
| Column             | Type    | Options                      | 
| ------------------ | ------- | ---------------------------- |
| nickname           | string  | null: false                  |
| email              | string  | null: false, unique: true    |
| encrypted_password | string  | null: false                  |
| last_name          | string  | null: false                  |
| first_name         | string  | null: false                  |
| last_name_kana     | string  | null: false                  |
| first_name_kana    | string  | null: false                  |
| birth_date         | date    | null: false                  |

### Association
has_many :items
has_many :purchase_records
has_many :comments



## itemsテーブル
| Column               | Type          | Options           | 
| -------------------- | ------------- | ----------------- |
| name                 | string        | null: false       |
| text                 | text          | null: false       |
| category_id          | integer       | null: false       |
| status_id            | integer       | null: false       |
| shipping_fee_id      | integer       | null: false       |
| prefecture_id        | integer       | null: false       |
| schedule_delivery_id | integer       | null: false       |
| price                | integer       | null: false       |
| user                 | references    | foreign_key: true |

### Association
belongs_to :user
has_one :purchase_record
has_many :comments



## purchase_recordsテーブル
| Column   | Type       | Options              | 
| -------- | ---------- | -------------------- |
| user     | references | foreign_key: true    |
| item     | references | foreign_key: true    |

### Association
belongs_to :user
belongs_to :item
has_one :order



## ordersテーブル
| Column           | Type         | Options               |
| ---------------- | ------------ | --------------------- |
| postal_cord      | string       | null: false           |
| prefecture_id    | integer      | null: false           |
| city             | string       | null: false           |
| address          | string       | null: false           |
| building         | string       |                       |
| phone_number     | string       | null: false           |
| purchase_record  | references   | foreign_key: true     |

### Association
belongs_to :purchase_record



## commentsテーブル
| Column     | Type       | Options           | 
| ---------- | ---------- | ----------------- |
| text       | text       | null: false       |
| user       | references | foreign_key: true |
| item       | references | foreign_key: true |

### Association
belongs_to :user
belongs_to :item
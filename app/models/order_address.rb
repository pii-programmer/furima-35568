class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_cord, :prefecture_id, :city, :address, :building, :phone_number, :order_id, :user_id, :item_id

  with_options presence:true do
    validates :postal_cord,    length: { maximum: 8 }, format: {with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id,  numericality: { other_than: 1 }
    validates :city,           format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :address,        format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]\d[-]\d+\z/ }
    validates :phone_number,   length: { maximum: 11 }, format: { with: /\A\d{10,11}\z/ }
    validates :order_id
    validates :user_id
    validates :item_id
  end
  validates :building,          format: { with: /\A[ぁ-んァ-ヶ一-龥々ー][a-zA-Z\d]+\z/i }
end
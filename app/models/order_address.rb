class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_cord, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence:true do
    validates :postal_cord,    length: { maximum: 8 }, format: {with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id,  numericality: { other_than: 1 }
    validates :city,           format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :address,        format: { with: /\A[ぁ-んァ-ヶ一-龥々ー].+\z/ }
    validates :phone_number,   length: { maximum: 11 }, format: { with: /\A\d{10,11}\z/ }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :building, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー].+\z/ }, allow_blank: true

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_cord: postal_cord, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end

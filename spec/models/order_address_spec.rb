require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep(1)
  end

  describe '商品購入機能' do
    context '商品購入できるとき' do
      it 'postal_cord、prefecture_id、city、building、address、phone_number、user_id、item_id、tokenが存在すれば購入できる' do
        expect(@order_address).to be_valid
      end
      it 'postal_cordは半角数字・ハイフン8文字以下であれば購入できる' do
        @order_address.postal_cord = '123-4567'
        expect(@order_address).to be_valid
      end
      it 'prefecture_idの値が1以外なら購入できる' do
        @order_address.prefecture_id = 2
        expect(@order_address).to be_valid
      end
      it 'cityは漢字・平仮名・片仮名であれば購入できる' do
        @order_address.city.match(/\A[ぁ-んァ-ヶ一-龥々ー]+\z/)
        expect(@order_address).to be_valid
      end
      it 'addressは漢字・平仮名・片仮名とハイフン・ピリオドを含む英数字であれば購入できる' do
        @order_address.address.match(/\A[ぁ-んァ-ヶ一-龥々ー].+\z/)
        expect(@order_address).to be_valid
      end
      it 'buildingは空でも購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
      it 'buildingは漢字・平仮名・片仮名とハイフン・ピリオドを含む英数字であれば購入できる' do
        @order_address.building.match(/\A[ぁ-んァ-ヶ一-龥々ー].+\z/)
        expect(@order_address).to be_valid
      end
      it 'phone_numberは半角数字11文字以下であれば購入できる' do
        @order_address.phone_number = '12345678901'
        expect(@order_address).to be_valid
      end
    end

    context '商品購入できないとき' do
      it 'postal_cordが空では購入できない' do
        @order_address.postal_cord = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal cord can't be blank", "Postal cord is invalid")
      end
      it 'postal_cordは半角数字・ハイフン以外の9文字以上では購入できない' do
        @order_address.postal_cord = '1234&56789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal cord is invalid")
      end
      it 'prefecture_idが空では購入できない' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank", "Prefecture is not a number")
      end
      it 'prefecture_idの値が1だと購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it 'cityが空では購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank", "City is invalid")
      end
      it 'cityは漢字・平仮名・片仮名以外では購入できない' do
        @order_address.city = 'Tokyo'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City is invalid")
      end
      it 'addressが空では購入できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank", "Address is invalid")
      end
      it 'addressは漢字・平仮名・片仮名とハイフン・ピリオドを含む英数字以外では購入できない' do
        @order_address.address = '¥&#%'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address is invalid")
      end
      it 'buildingは漢字・平仮名・片仮名とハイフン・ピリオドを含む英数字以外では購入できない' do
        @order_address.building = '¥&#%'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Building is invalid")
      end
      it 'phone_numberが空では購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank", "Phone number is invalid")
      end
      it 'phone_numberは半角数字以外の12文字以上では購入できない' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberは英数字混合では購入できない' do
        @order_address.phone_number = '1k2a3cf45g8'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'userが紐づいていないと購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていないと購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end

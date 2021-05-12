require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できるとき' do
      it 'nameとtext、category_idとstatus_id、shipping_fee_idとprefecture_idとschedule_delivery_id、price、user_idとimageが存在すれば出品できる' do
        expect(@item).to be_valid
      end
      it 'nameは40文字以下であれば出品できる' do
        @item.name = 'bbbbbb'
        expect(@item).to be_valid
      end
      it 'textは1000文字以下であれば出品できる' do
        @item.text = 'abcabc.'
        expect(@item).to be_valid
      end
      it 'category_idの値が1以外なら出品できる' do
        @item.category_id = 2
        expect(@item).to be_valid
      end
      it 'status_idの値が1以外なら出品できる' do
        @item.status_id = 2
        expect(@item).to be_valid
      end
      it 'shipping_fee_idの値が1以外なら出品できる' do
        @item.shipping_fee_id = 2
        expect(@item).to be_valid
      end
      it 'prefecture_idの値が1以外なら出品できる' do
        @item.prefecture_id = 2
        expect(@item).to be_valid
      end
      it 'schedule_delivery_idの値が1以外なら出品できる' do
        @item.schedule_delivery_id = 2
        expect(@item).to be_valid
      end
      it 'priceは半角数字なら出品できる' do
        @item.price = 3000
        expect(@item).to be_valid
      end
      it 'priceは300以上9999999以下なら出品できる' do
        @item.price = 3000
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'nameが41文字以上では出品できない' do
        @item.name = Faker::Lorem.characters(number: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
      end
      it 'textが空では出品できない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end
      it 'textが1001文字以上では出品できない' do
        @item.text = Faker::Lorem.characters(number: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include("Text is too long (maximum is 1000 characters)")
      end
      it 'category_idの値が1だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it 'status_idの値が1だと出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 1")
      end
      it 'shipping_fee_idの値が1だと出品できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee must be other than 1")
      end
      it 'prefecture_idの値が1だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it 'schedule_delivery_idの値が1だと出品できない' do
        @item.schedule_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Schedule delivery must be other than 1")
      end
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが299以下だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが10000000以上だと出品できない' do
        @item.price = Faker::Number.between(from: 10000000, to: 10000001)
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'priceが半角英語だけでは出品できない' do
        @item.price = 'pricealpha'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが半角英数混合では出品できない' do
        @item.price = 'pr1cea1ha'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが全角文字では出品できない' do
        @item.price = 'プライス'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'userが紐づいていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end

  end

end

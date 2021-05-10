require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザーの新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_kanaとfirst_name_kanaが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nicknameは40文字以下であれば登録できる' do
        @user.nickname = 'aaaaaa'
        expect(@user).to be_valid
      end
      it 'emailは@を含んでいれば登録できる' do
        @user.email.match(/@/)
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationは6文字以上であれば登録できる' do
        @user.password = 'a0a0a0'
        @user.password_confirmation = 'a0a0a0'
        expect(@user).to be_valid
      end
      it 'passwordは半角英数字混合であれば登録できる' do
        @user.password.match(/\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i)
        expect(@user).to be_valid
      end
      it 'last_nameは全角ひらがな漢字カタカナであれば登録できる' do
        @user.last_name.match(/\A[ぁ-んァ-ヶ一-龥々ー]+\z/)
        expect(@user).to be_valid
      end
      it 'first_nameは全角ひらがな漢字カタカナであれば登録できる' do
        @user.first_name.match(/\A[ぁ-んァ-ヶ一-龥々ー]+\z/)
        expect(@user).to be_valid
      end
      it 'last_name_kanaは全角カタカナであれば登録できる' do
        @user.last_name_kana.match(/\A[ァ-ヶー]+\z/)
        expect(@user).to be_valid
      end
      it 'first_name_kanaは全角カタカナであれば登録できる' do
        @user.first_name_kana.match(/\A[ァ-ヶー]+\z/)
        expect(@user).to be_valid
      end
      it 'birth_dateは存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'nicknameは41文字以上では登録できない' do
        @user.nickname = 'fdfwertyuikmnbvcsijbcdsertyuuyfdvbhgfwerg'
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is too long (maximum is 40 characters)")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが存在しても、password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is invalid")
      end
      it 'passwordとpassword_confirmationは5文字以下では登録できない' do
        @user.password = 'a0a0a'
        @user.password_confirmation = 'a0a0a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
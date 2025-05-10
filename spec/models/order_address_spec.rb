require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    sleep(0.3)
  end

  context '商品購入できる場合' do
    it 'すべての項目が正しく入力されていれば購入できる' do
      expect(@order_address).to be_valid
    end

    it '建物名が空欄でも、建物名以外の項目が正しく入力されていれば購入できる' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end

  end

  context '商品出品できない場合' do
    it 'userが紐づいていなければ購入できない' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Userを入力してください')
    end

    it 'itemが紐づいていなければ購入できない' do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Itemを入力してください')
    end

    it '郵便番号が空では購入できない' do
      @order_address.postcode = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('郵便番号を入力してください')
    end

    it '郵便番号が入力されているが、指定の形式と異なる場合は購入できない' do
      @order_address.postcode = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('郵便番号は「3桁ハイフン4桁」の半角文字列形式で入力してください(良い例：123-4567　良くない例：1234567)')
    end

    it '都道府県が空(「---」に対応するid)では購入できない' do
      @order_address.prefecture_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('都道府県を入力してください')
    end

    it '市区町村が空では購入できない' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('市区町村を入力してください')
    end

    it '番地が空では購入できない' do
      @order_address.address = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('番地を入力してください')
    end

    it '電話番号が空では購入できない' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('電話番号を入力してください')
    end

    it '電話番号が入力されているが、指定の形式と異なる場合は購入できない' do
      @order_address.phone_number = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値で入力してください(良い例：09012345678　良くない例：090-1234-5678)')
    end

    it '電話番号が9桁以下では購入できない' do
      @order_address.phone_number = '123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値で入力してください(良い例：09012345678　良くない例：090-1234-5678)')
    end

    it '電話番号が12桁以上では購入できない' do
      @order_address.phone_number = '123456789101112'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値で入力してください(良い例：09012345678　良くない例：090-1234-5678)')
    end

    it 'クレジットカード情報が空では購入できない' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('クレジットカード情報を入力してください')
    end
  end
end

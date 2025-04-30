require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '商品出品できる場合' do
    it 'すべての項目が正しく入力されていれば保存できる' do
      expect(@item).to be_valid
    end
  end

  context '商品出品できない場合' do

    it 'userが紐づいていないと出品できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Userを入力してください')
    end

    it '商品画像が空では保存できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('商品画像を入力してください')
    end

    it '商品名が空では保存できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include('商品名を入力してください')
    end

    it '商品名が40文字を超えると保存できない' do
      @item.name = 'a' * 41
      @item.valid?
      expect(@item.errors.full_messages).to include('商品名は40文字以内で入力してください')
    end

    it '商品説明が空では保存できない' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include('商品の説明を入力してください')
    end

    it '商品説明が1000文字を超えると保存できない' do
      @item.description = 'a' * 1001
      @item.valid?
      expect(@item.errors.full_messages).to include('商品の説明は1000文字以内で入力してください')
    end

    it 'カテゴリーを選択していないと保存できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('カテゴリーを入力してください')
    end

    it '商品の状態を選択していないと保存できない' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('商品の状態を入力してください')
    end

    it '配送料の負担を選択していないと保存できない' do
      @item.delivery_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('配送料の負担を入力してください')
    end

    it '発送元の地域を選択していないと保存できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('発送元の地域を入力してください')
    end

    it '発送までの日数を選択していないと保存できない' do
      @item.shipping_day_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('発送までの日数を入力してください')
    end

    it '価格が空では保存できない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('販売価格を入力してください')
    end

    it '価格が300未満では保存できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('販売価格は¥300~¥9,999,999（整数値）の間で設定してください')
    end

    it '価格が10,000,000以上では保存できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('販売価格は¥300~¥9,999,999（整数値）の間で設定してください')
    end

    it '価格が半角数値以外では保存できない' do
      @item.price = '３００円'
      @item.valid?
      expect(@item.errors.full_messages).to include('販売価格は¥300~¥9,999,999（整数値）の間で設定してください')
    end

    it '価格が整数以外では登録できない' do
      @item.price = 300.5
      @item.valid?
      expect(@item.errors.full_messages).to include('販売価格は¥300~¥9,999,999（整数値）の間で設定してください')
    end
  end
end

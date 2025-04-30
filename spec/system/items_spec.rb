require 'rails_helper'

RSpec.describe '商品出品', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context '商品出品ができるとき' do
    it 'ログインしていれば商品出品ページに遷移して出品できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_button 'ログイン'

      # 出品ページへ移動
      visit new_item_path

      # フォームを埋める
      fill_in 'item-name', with: 'neko'
      fill_in 'item-info', with: 'ネコのイラストです'
      select 'おもちゃ・ホビー・グッズ', from: 'category-list'
      select '新品・未使用', from: 'item-sales-status'
      select '着払い(購入者負担)', from: 'item-shipping-fee-status'
      select '香川県', from: 'item-prefecture'
      select '2~3日で発送', from: 'item-scheduled-delivery'
      fill_in 'item-price', with: 1000
      attach_file('image', Rails.root.join('public/images/test_image.png'))
      # 出品するボタンを押す
      expect do
        find('input[name="commit"]').click
        sleep 1
      end.to change { Item.count }.by(1)
      # トップページに遷移
      expect(current_path).to eq(root_path)
    end
  end

  context '商品出品ができないとき' do
    it 'ログアウト状態では出品ページにアクセスできずログインページにリダイレクトされる' do
      visit new_item_path
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

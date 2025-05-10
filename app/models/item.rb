class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_one_attached :image
  has_one :order

  belongs_to :user
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :description,  length: { maximum: 1000 }
    validates :price
    validates :image
  end

  with_options numericality: { other_than: 1, message: 'を入力してください' } do
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :shipping_day_id
  end

  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: 'は¥300~¥9,999,999（整数値）の間で設定してください'
  }
end

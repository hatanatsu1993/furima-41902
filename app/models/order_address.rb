class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :address, :building, :phone_number, :order_id, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「3桁ハイフン4桁」の半角文字列形式で入力してください(良い例：123-4567　良くない例：1234567)' }
  end

  validates :prefecture_id, numericality: { other_than: 1, message: 'を入力してください' }

  with_options presence: true do
    validates :city
    validates :address
    validates :phone_number,
              format: { with: /\A\d{10,11}\z/, message: 'は10桁以上11桁以内の半角数値で入力してください(良い例：09012345678　良くない例：090-1234-5678)' }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postcode: postcode,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end

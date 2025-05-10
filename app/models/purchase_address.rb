class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :ite_id, :postcode, :prefecture_id, :city, :building, :phone_number, :purchase_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode , format:{with: ^\d{3}-\d{4}$, message: "エラーメッセージ"}
    validates :prefecture_id
    validates :city
    validates :address
    validates :building
    validates :phone_number, format:{with: ^\d{10,11}$, message: "エラーメッセージ"}
    validates :purchase_id
  end

  def save
    parchase = Parchase.create(user_id: user_id,item_id: item_id )
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end

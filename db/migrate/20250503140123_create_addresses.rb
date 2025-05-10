class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :postcode, null: false
      t.integer :prefecture_id, null: false
      t.integer :city , null: false
      t.integer :address, null: false
      t.integer :building
      t.integer :phone_number, null: false
      t.references :order , null: false, foreign_key: true
      t.timestamps
    end
  end
end

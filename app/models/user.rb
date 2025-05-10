class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders


  with_options presence: true do
    # ニックネーム
    validates :nickname
    # パスワード
    validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は半角英数字混合6文字以上で入力してください' }
    # 姓名
    validates :family_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角で入力してください' }
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角で入力してください' }
    # 姓名フリガナ
    validates :family_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' }
    validates :last_name_kana,   format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' }
    # 生年月日
    validates :birthday
  end
end

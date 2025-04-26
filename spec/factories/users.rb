FactoryBot.define do
  factory :user do
    nickname              { "yamada" }
    email                 { "yamada@gmail.com" }
    password              { "00000000a" }
    password_confirmation { "00000000a" }
    family_name           { "山田" }
    last_name             { "太郎" }
    family_name_kana      { "ヤマダ" }
    last_name_kana        { "タロウ" }
    birthday              { "2020-01-01" }
  end
end

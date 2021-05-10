FactoryBot.define do
  factory :user do
    nickname               {Faker::Name.initials}
    email                  {Faker::Internet.free_email}
    password = '1a' + Faker::Internet.password(min_length:6)
    password               {password}
    password_confirmation  {password}
    last_name              {Gimei.last.kanji}
    first_name             {Gimei.first.kanji}
    last_name_kana         {Gimei.last.katakana}
    first_name_kana        {Gimei.first.katakana}
    birth_date             {Faker::Date.birthday}
  end
end
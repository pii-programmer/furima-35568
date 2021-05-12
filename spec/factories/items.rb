FactoryBot.define do
  factory :item do
    name                  {Faker::Lorem.word}
    text                  {Faker::Lorem.sentence}
    category_id           {Faker::Number.between(from: 2, to: 3)}
    status_id             {Faker::Number.between(from: 2, to: 3)}
    shipping_fee_id       {Faker::Number.between(from: 2, to: 3)}
    prefecture_id         {Faker::Number.between(from: 2, to: 3)}
    schedule_delivery_id  {Faker::Number.between(from: 2, to: 3)}
    price                 {Faker::Number.between(from: 300, to: 9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/kodomofuku_girl.png'), filename: 'kodomofuku_girl.png' )
    end
  end
end

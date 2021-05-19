FactoryBot.define do
  factory :order_address do
    postal_cord    { '123-4567' }
    prefecture_id  {Faker::Number.between(from: 2, to: 3)}
    city           { '東京都' }
    address        { '渋谷区1-1-1' }
    building       { '渋谷10qビル' }
    phone_number   { '12345678901' }
    token {"pk_test_abcdefghij98765432101234"}
    
  end
end

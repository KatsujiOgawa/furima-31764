FactoryBot.define do
  factory :item do
    name                  {"商品名です"}
    info                  {"商品詳細記入欄です"}
    price                 {"99999"}
    category_id           {"2"}
    condition_id          {"2"}
    shipping_payer_id     {"2"}
    prefecture_id         {"2"}
    shipping_day_id       {"2"}
    association :user 
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
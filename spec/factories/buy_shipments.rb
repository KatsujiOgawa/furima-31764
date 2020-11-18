FactoryBot.define do
  factory :buy_shipment do
    postal_code      {"123-1234"}
    prefecture_id    {"2"}
    city             {"町田市"}
    house_number     {"町1-1-1"}
    building_name    {"町田ビル"}
    phone_number     {"08012345678"}
    token            {"tok_abcdefghijk00000000000000000"}
    association :user 
    association :item
  end
end

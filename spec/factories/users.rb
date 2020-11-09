FactoryBot.define do
  factory :user do
    nickname                {Faker::Name.initials(number: 2)}
    email                   {Faker::Internet.free_email}
    password                {"abc123"}
    password_confirmation   {password}
    first_name              {"勝次"}
    last_name               {"小川"}
    first_name_katakana     {"カツジ"}
    last_name_katakana      {"オガワ"}
    birthday_id             {"1932-03-03"}
  end
end
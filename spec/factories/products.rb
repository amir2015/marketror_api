#rubocop:disable all
FactoryBot.define do
  factory :product do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    price { rand * 100 }
    published { false }
    user
  end
end

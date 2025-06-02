#rubocop:disable all
FactoryBot.define do
  factory :product do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    price { rand * 100 }
    published { false }
    quantity {3}
    user
  end
end

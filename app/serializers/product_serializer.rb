#rubocop:disable all
class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :published, :price
  has_one :user, serializer: UserSerializer
end

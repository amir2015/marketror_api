class ProductSerializer < ActiveModel::Serializer
  attributes :id,:title,:published,:price
end

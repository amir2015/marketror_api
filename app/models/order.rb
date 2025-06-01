class Order < ApplicationRecord
  before_validation :set_total,if: -> { (total.nil? || total.zero?) && product_ids.present? }

  belongs_to :user
  has_many :placements
  has_many :products, through: :placements

  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
  def set_total
    self.total = products.map(&:price).sum
  end

  def build_placements_with_products_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id, quantity|
      placements.build(product_id: product_id, quantity: quantity)
    end
  end
end

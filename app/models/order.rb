class Order < ApplicationRecord
  before_validation :set_total,if: -> { (total.nil? || total.zero?) && product_ids.present? }

  belongs_to :user
  has_many :placements,inverse_of: :order, dependent: :destroy
  has_many :products, through: :placements

  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
  def set_total
    self.total = placements.map { |p| p.product.price * p.quantity }.sum
  end

  def build_placements_with_products_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_ids_quantitiy|
      id, quantity = product_ids_quantitiy
      placements.build(product_id: id, quantity: quantity)
    end
  end
end

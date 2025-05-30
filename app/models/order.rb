class Order < ApplicationRecord
  before_validation :set_total,if: -> { (total.nil? || total.zero?) && product_ids.present? }
  belongs_to :user
  has_many :placements, inverse_of: :order, dependent: :destroy
  has_many :products, through: :placements

  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
  def set_total
    self.total = products.map(&:price).sum
  end
end

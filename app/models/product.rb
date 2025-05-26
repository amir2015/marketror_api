#rubocop:disable all
class Product < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, :user_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  scope :by_title, ->(title) { where("lower(title) LIKE ?", "%#{title}%") }
end

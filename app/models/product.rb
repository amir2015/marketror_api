#rubocop:disable all
class Product < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, :user_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  scope :by_title, ->(title) { where("lower(title) LIKE ?", "%#{title}%") }
  scope :by_below_or_equal_price,->(price)  { where("price <=?", price) }
  scope :by_above_or_equal_price,->(price)  { where("price >=?", price) }
  scope :by_published, -> { where(published: true) }
  scope :by_recent, -> { order(created_at: :desc) }
  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :by_recent_updated,-> { order(updated_at: :desc) }

  def self.search(params={})
    product_ids = params[:products_ids]

    keyword_params = params[:keyword]
    max_price_params = params[:max_price]
    min_price_params = params[:min_price]

    products=product_ids.present? ? Product.where(id: product_ids) : Product.all


    products=products.by_title(keyword_params) if keyword_params.present?

    products=products.by_below_or_equal_price(max_price_params) if max_price_params
    products=products.by_above_or_equal_price(min_price_params) if min_price_params

    products
  end
end

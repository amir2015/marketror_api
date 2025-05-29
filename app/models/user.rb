#rubocop:disable all
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :products,dependent: :destroy
  has_many :orders, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :token, uniqueness: { case_sensitive: true }
  before_create :generate_token

  def generate_token
    begin
      self.token = Devise.friendly_token
    end while self.class.exists?(token: token)
  end
end

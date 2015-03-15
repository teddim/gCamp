class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, :last_name,:email, presence: true
  validates :email, uniqueness: true

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  def full_name
    full_name = "#{self.first_name} #{self.last_name}"
  end

end

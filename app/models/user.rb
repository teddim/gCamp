class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, :last_name,:email, presence: true
  validates :email, uniqueness: true

  has_many :memberships
  has_many :projects, through: :memberships

  #enum role: {member: 0, owner: 1}

  def full_name
    full_name = "#{self.first_name} #{self.last_name}"
  end

end

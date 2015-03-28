class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, :last_name,:email, presence: true
  validates :email, uniqueness: true

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :comments

  def full_name
    full_name = "#{self.first_name} #{self.last_name}"
  end

  def set_comment_user_id_to_nil(comment)
    comment.user_id = nil
  end

  def is_project_member(project)
    if project.memberships.find_by(user_id: self.id)
      return true
    else
      false
    end
  end

  def is_project_owner(project)
    if self.memberships.where(project_id: project).where(role: "owner").present?
      return true
    else
      false
    end
  end

  def is_last_project_owner(project)
    if project.memberships.where(role: "owner").pluck(:id).count == 1
      return true
    else
      false
    end
  end

  def is_authorized(user)
    if self.id == user
      binding.pry
      user
    else
      false
    end
  end

end

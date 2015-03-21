class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  validates :user, presence: true, uniqueness: {scope: :project_id, message: "has already been added to this project"}

  OWNER = 'owner'
  MEMBER = 'member'
  ROLES = [MEMBER,OWNER]
end

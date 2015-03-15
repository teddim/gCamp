class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  validates :user, presence: true

  OWNER = 'owner'
  MEMBER = 'member'
  ROLES = [MEMBER,OWNER]
end

class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  OWNER = 'owner'
  MEMBER = 'member'
  ROLES = [MEMBER,OWNER]
end

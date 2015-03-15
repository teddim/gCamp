class Comment < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  validates :content, :task_id, :user_id, presence: true
  belongs_to :task
  belongs_to :user

  def time_in_words
    #time = "self.created_at"
    "#{time_ago_in_words(self.created_at, options = {})} ago"


  end
end

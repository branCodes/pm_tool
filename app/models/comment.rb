class Comment < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :discussion
  belongs_to :user
end

class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup

  validates :meetup_id, :user_id, :presence => true
  validates :user_id, :uniqueness => { :scope => :meetup_id }
end

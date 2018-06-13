class Participant < ActiveRecord::Base
  #attr_accessible :user, :meetup, :quizzes_attributes, :accepted, :meetup_id, :user_id, :created_at
  belongs_to :user
  belongs_to :meetup
  has_many :quizzes

  accepts_nested_attributes_for :quizzes

  delegate :email, to: :user

  validates :meetup_id, :user_id, :presence => true
  validates :user_id, uniqueness: { scope: :meetup_id }
  validates_associated :quizzes

  scope :participants_on, lambda { |meetup_ids|
    if meetup_ids.present?
      where('participants.meetup_id' => meetup_ids)
    end
  }
end

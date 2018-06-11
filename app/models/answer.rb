class Answer < ActiveRecord::Base
  belongs_to :question
  validates :gist, presence: true
end

class TwitterBlock < ActiveRecord::Base
  validates :search, :presence => true
end

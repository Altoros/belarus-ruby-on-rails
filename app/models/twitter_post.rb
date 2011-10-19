class TwitterPost < ActiveRecord::Base
  validates :search, :presence => true
end

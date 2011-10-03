class Experience < ActiveRecord::Base
  validates :level, :presence => true
  validates :level, :uniqueness => true
  validates :level, :length => { :maximum => 25 }
end

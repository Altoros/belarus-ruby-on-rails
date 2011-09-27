class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :first_name, :last_name
  validates :first_name, :presence => true
  validates :first_name, :length => {:maximum => 255}
  validates :last_name, :presence => true
  validates :last_name, :length => {:maximum => 255}

  def full_name
    "#{ first_name } #{ last_name }"
  end
end

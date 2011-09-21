class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :first_name, :last_name
  validates :first_name, :presence => {:message => I18n.translate(:cant_be_blank)}
  validates :first_name, :length => {:maximum => 255, :message => I18n.translate(:has_not_valid_size)}
  validates :last_name, :presence => {:message => I18n.translate(:cant_be_blank)}
  validates :last_name, :length => {:maximum => 255, :message => I18n.translate(:has_not_valid_size)}
end

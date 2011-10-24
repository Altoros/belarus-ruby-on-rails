class StaticPage < ActiveRecord::Base
  validates :title, :content, :permalink, :presence => true
end
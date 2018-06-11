class TwitterBlock < ActiveRecord::Base
  validates_presence_of :widget, :title
end

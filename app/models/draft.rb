class Draft < ActiveRecord::Base
  validates :object_type, presence: true
  validates :object_id, presence: true
  validates :draft_object, presence: true
end

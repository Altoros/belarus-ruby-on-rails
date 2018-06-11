class AggregatorConfiguration < ActiveRecord::Base
  validates :source, presence: true
  serialize :feed_object
end

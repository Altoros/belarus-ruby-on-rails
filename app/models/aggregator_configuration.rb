class AggregatorConfiguration < ActiveRecord::Base
  validates :source, :presence => true
end

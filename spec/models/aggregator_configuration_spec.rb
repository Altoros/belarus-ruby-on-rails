require 'spec_helper'

describe AggregatorConfiguration do
  it "should be valid" do
    configuration = Factory.build(:aggregator_configuration)
    configuration.should be_valid
  end

  it "should not be valid without search" do
    configuration = Factory.build(:aggregator_configuration, :source => "")
    configuration.should have(1).error_on(:source)
  end
end

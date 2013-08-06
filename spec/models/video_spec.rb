require 'spec_helper'

describe Video do
  it "should create a new instance given a valid attribute" do
    Video.delete_all
    FactoryGirl.create(:video)

    Video.all.should have(1).item
  end
end

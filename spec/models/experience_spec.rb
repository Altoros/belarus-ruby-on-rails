require 'spec_helper'

describe Experience do
  subject { Experience.new }

  it { should respond_to(:level) }
  it { should have(1).error_on(:level) }

  it "is not valid if level field is longer than 25 symbols" do
    experience = Factory.build(:experience, :level => "a" * 26 )
    experience.should have(1).error_on(:level)
  end

  it "is not valid if level field is duplicated" do
    experience = Factory(:experience)
    another_experience = Factory.build(:experience, :level => experience.level)

    another_experience.should have(1).error_on(:level)
  end

  it "has many profiles" do
    experience = Factory(:experience)

    2.times do
      Factory(:profile, :subscribed => true, :experience => experience)
    end

    experience.profiles.should have(2).items
  end
end

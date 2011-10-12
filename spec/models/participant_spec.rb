require 'spec_helper'

describe Participant do
  subject { Participant.new }

  it { should respond_to(:meetup) }
  it { should respond_to(:user) }
  it { should have_at_least(1).error_on(:meetup_id) }
  it { should have_at_least(1).error_on(:user_id) }

  it 'unique record for each user per meetup' do
    meetup_attributes = { :user_id => 1, :meetup_id => 1 }
    Participant.create(meetup_attributes)
    Participant.create(meetup_attributes).should have_at_least(1).error_on(:user_id)
  end
end

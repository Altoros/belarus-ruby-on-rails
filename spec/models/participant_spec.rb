require 'spec_helper'

describe Participant do
  subject { Participant.new }

  it { should respond_to(:meetup) }
  it { should respond_to(:user) }
  it { should have_at_least(1).error_on(:meetup_id) }
  it { should have_at_least(1).error_on(:user_id) }

  it 'unique record for each user per meetup' do
    Factory(:participant)
    lambda{ Factory(:participant) }.should raise_error(ActiveRecord::RecordInvalid)
  end
end

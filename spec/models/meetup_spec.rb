require 'spec_helper'

describe Meetup do
  subject { Meetup.new }

  it { should have_many(:participants) }
  it { should have_many(:questions) }
  it { should have_many(:articles) }
  it { should validate_presence_of(:date_and_time) }
  it { should validate_presence_of(:finish_date_and_time) }
  it { should have_db_column(:status).of_type(:boolean)
                              .with_options(default: true) }
end

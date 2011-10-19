FactoryGirl.define do
  factory :message do
    recipient_group [UsersFilter::ALL_OPTION]
    subject 'Subject of message'
    body 'Body of message'
  end
end

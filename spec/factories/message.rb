FactoryGirl.define do
  factory :message do
    recipient_group 'all'
    subject 'Subject of message'
    body 'Body of message'
  end
end

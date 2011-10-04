FactoryGirl.define do
  factory :message do
    recipient_group '0'
    subject 'Subject of message'
    body 'Body of message'
  end
end

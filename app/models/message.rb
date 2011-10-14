class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :recipient_group, :subject, :body

  validates_each :recipient_group do |model, attribute, values|
    filters = UsersFilter.collection.keys
    model.errors.add attribute, I18n.t('admin.messages.invalid_user_group')  if values != (values & filters)
  end
  validates :subject, :presence=> true, :length => {:minimum => 3, :maximum => 100}
  validates :body, :presence => true, :length => {:minimum => 5, :maximum => 500}

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def self.deliver(recipient_group, subject, body)
    emails_list = recipient_group.inject([]) do |res, filter|
      res |= UsersFilter.emails_list(filter)
    end

    emails_list.each do |email|
      Notifier.custom(email, subject, body).deliver
    end
  end
end

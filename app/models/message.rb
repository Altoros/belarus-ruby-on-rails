class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :recipient_group, :subject, :body, :reversed, :accepted

  validates_each :recipient_group do |model, attribute, values|
    filters = Meetup.list_of_meetups
    values.delete_if(&:blank?) if values.present?
    model.errors.add attribute, I18n.t('admin.messages.invalid_user_group')  if values && values != (values & filters)
  end
  validates :subject, presence: true
  validates :body, presence: true

  class << self
    def deliver(recipient_group, subject, body, reversed, accepted)
      recipient_group.delete_if(&:blank?) if recipient_group.present?
      accepted_recipients = Profile.subscribed.accepted(accepted)
      list_of_recipients(recipient_group, reversed, accepted_recipients).each do |recipient|
        Notifier.delay.broadcast_message(recipient.user.email, subject, body)
      end
    end
    handle_asynchronously :deliver unless Rails.env.test?

    def list_of_recipients(recipient_group, reversed, accepted_recipients)
      reversed == "yes" ? reversed_list_of_recipients(recipient_group, accepted_recipients) :
          accepted_recipients.filter(recipient_group).includes(:user).uniq
    end

    def reversed_list_of_recipients(recipient_group, accepted_recipients)
      recipient_group ? accepted_recipients.filter(Meetup.list_of_meetups - recipient_group).includes(:user).uniq :
          accepted_recipients.filter(recipient_group).includes(:user).uniq
    end
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end

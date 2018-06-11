class Profile < ActiveRecord::Base
  LOCALES = [[I18n.t("languages.ru"), "ru"], [I18n.t("languages.en"), "en"]]

  belongs_to :user
  belongs_to :experience

  has_attached_file :avatar, :styles => { :medium => "98x98#", :thumb => "50x50#" },
                    :path => ":rails_root/public/system/:attachment/#{Rails.env}/:id/:style/:filename",
                    :url => "/system/:attachment/#{Rails.env}/:id/:style/:filename"

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :experience_id, presence: true
  validates_attachment_content_type :avatar, {
      content_type: ['image/png', 'image/gif', 'image/x-png', 'image/jpeg', 'image/jpg'],
      message: I18n.t('profile.wrong_image_type')}

  accepts_nested_attributes_for :user

  scope :subscribed, -> { where('profiles.subscribed = ?', true) }
  scope :subscribed_for_comments, -> { where('profiles.subscribed_for_comments = ?', true) }
  scope :participants_on, lambda { |meetup_ids|
    joins('INNER JOIN participants ON participants.user_id = profiles.user_id')
      .where('participants.meetup_id' => meetup_ids)
  }
  scope :accepted, lambda { |accepted|
    unless accepted.blank?
      joins('INNER JOIN participants ON participants.user_id = profiles.user_id')
      .where('participants.accepted' => accepted)
    end
  }
  scope :filter, lambda{ |*filters|
    filters = filters.flatten.compact
    if filters.present?
      participants_on(filters)
    end
  }

  def providers_data
    tokens = self.user.user_tokens
    User.omniauth_providers.inject([]) do |res, provider|
      if token = tokens.detect { |obj| obj.provider == provider.to_s}
        res << Provider::Factory.get_instance(provider, token.uid)
      else
        res << Provider::Factory.get_instance(provider)
      end
      res
    end
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def errors_on_avatar
    if errors.present?
      res = []
      errors.messages.map { |field, msg| res << msg if field.to_s.include?('avatar')}
      res.flatten
    end
  end
end

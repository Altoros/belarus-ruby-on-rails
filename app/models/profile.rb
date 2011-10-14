class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :experience

  attr_accessible :first_name,
                  :last_name,
                  :subscribed,
                  :experience_id,
                  :subscribed_for_comments

  validates :first_name, :presence => true,
            :length => { :maximum => 255 }
  validates :last_name, :presence => true,
            :length => { :maximum => 255 }
  validates :experience_id, :presence => true

  scope :subscribed, where('subscribed = ?', true).joins(:user).merge(User.not_admin)
  scope :subscribed_for_comments, where('subscribed_for_comments = ?', true)
  scope :participants_on, lambda { |meetup_id|
    subscribed.joins('INNER JOIN participants ON participants.user_id = users.id')
      .where('participants.meetup_id = ?', meetup_id)
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
end

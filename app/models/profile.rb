class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :first_name, :last_name, :subscribed_for_comments
  validates :first_name, :presence => true
  validates :first_name, :length => {:maximum => 255}
  validates :last_name, :presence => true
  validates :last_name, :length => {:maximum => 255}
  validates :experience, :presence => true, :if => :subscribed

  belongs_to :experience

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

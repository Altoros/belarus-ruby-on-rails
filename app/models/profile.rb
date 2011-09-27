class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :first_name, :last_name
  validates :first_name, :presence => true
  validates :first_name, :length => {:maximum => 255}
  validates :last_name, :presence => true
  validates :last_name, :length => {:maximum => 255}

  def providers_data
    res = []
    tokens = self.user.user_tokens
    User.omniauth_providers.each do |provider|
      if token = tokens.select { |obj| obj.provider == provider.to_s}.first
        res << Provider::Factory.get_instance(provider, token.uid)
      else
        res << Provider::Factory.get_instance(provider)
      end
    end
    res
  end
end

class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :recipient_group, :subject, :body

  validates :recipient_group, :inclusion => { :in => UsersFilter.filters_collection.keys.map{ |el| el.to_s },
                                              :message => I18n.t('admin.messages.invalid_user_group')}
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
end

class Meetup < ActiveRecord::Base
  attr_accessible :topic, :description, :place, :date_and_time

  validates :topic, :presence => true
  validates :topic, :length => {:maximum => 255}
  validates :description, :presence => true
  validates :place, :presence => true
  validates :place, :length => {:maximum => 255}

  validates_acceptance_of :date_and_time, :if => Proc.new { |meetup| meetup.date_and_time.past? }, :message => I18n.t('meetup.datetime_must_future')

  scope :future, lambda { {:conditions => ['date_and_time > ? AND cancelled = 0', Time.new]} }
  scope :id_desc, order('id DESC')
end

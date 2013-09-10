require 'icalendar2'
include Icalendar2

class Meetup < ActiveRecord::Base
  attr_accessible :topic, :description, :place, :date_and_time, :questions_attributes, :letter_subject, :letter_body,
                  :url, :premoderation, :decline_email_subject, :decline_email_body, :accept_email_subject, :accept_email_body,
                  :finish_date_and_time, :status

  has_many :participants
  has_many :questions
  has_many :articles

  accepts_nested_attributes_for :questions, :allow_destroy => true

  validates :topic, :presence => true
  validates :topic, :length => {:maximum => 255}
  validates :description, :presence => true
  validates :description, :length => {:maximum => 500}
  validates :place, :presence => true
  validates :place, :length => {:maximum => 255}
  validates :date_and_time, :presence => true
  validates :finish_date_and_time, :presence => true
  validates_acceptance_of :date_and_time, :if => Proc.new { |meetup| meetup.date_and_time && meetup.date_and_time.past? }, :message => I18n.t('meetup.datetime_must_future')
  validates_acceptance_of :finish_date_and_time, :if => Proc.new { |meetup| meetup.finish_date_and_time && meetup.finish_date_and_time < meetup.date_and_time }, :message => I18n.t('meetup.finish_after_start')
  validates :letter_subject, :presence => true
  validates :letter_body, :presence => true

  scope :active, lambda { where('date_and_time > ? AND cancelled = ?', Time.new, false) }
  scope :recent, order('date_and_time')

  def participant?(user)
    self.participants.where('user_id = ?', user.id).present? if user
  end

  def active?
    self.date_and_time > Time.new && !self.cancelled
  end

  def self.list_of_meetups
    Meetup.all.map{ |el| el.id.to_s }
  end

  def export_to_ics
    calendar = Calendar.new
    meetup = self
    calendar.event do
      dtstart     DateTime.parse(meetup.date_and_time.to_s)
      dtend       DateTime.parse(meetup.finish_date_and_time.to_s)
      summary     meetup.topic
      description meetup.description
    end

    calendar.to_ical
  end
end

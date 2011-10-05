class CorrectDateTimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << I18n.t('admin.meetup.incorrect_datetime_format') if value.nil?
  end
end

class DateTimeInFutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << I18n.t('admin.meetup.datetime_must_future') if value.nil? || value.past?
  end
end

class Meetup < ActiveRecord::Base
  attr_accessible :title, :description, :address, :date_and_time

  validates :title, :presence => true
  validates :title, :length => {:maximum => 255}
  validates :description, :presence => true
  validates :address, :presence => true
  validates :address, :length => {:maximum => 255}
  validates :date_and_time, :correct_date_time => true
  validates :date_and_time, :date_time_in_future => true

end

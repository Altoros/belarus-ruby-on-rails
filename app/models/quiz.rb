class Quiz < ActiveRecord::Base
  serialize :answer
  belongs_to :participant
  belongs_to :question
  validate :answer_presence
  validate :one_answer_must_be_checked
  validate :answer_length

  private
  def one_answer_must_be_checked
    if self.answer.class == Array && (self.answer - [""]).blank?
      errors.add(:answer, I18n.t("meetup.nothing_selected"))
    end
  end

  def answer_presence
    if self.answer.class != Array && self.answer.blank? && self.question.required
      errors.add(:answer, I18n.t("meetup.can_not_be_blank"))
    end
  end

  def answer_length
    if [2, 3].include?(self.question.kind_of_response)
      if self.question.min_length && self.answer.length < self.question.min_length
        errors.add(:answer, I18n.t("meetup.can_not_be_less_than", :min_length => self.question.min_length))
      end

      if self.question.length && self.answer.length != self.question.length
        errors.add(:answer, I18n.t("meetup.must_be_equal_to", :length => self.question.length))
      end

      if self.question.max_length && self.answer.length > self.question.max_length
        errors.add(:answer, I18n.t("meetup.can_not_be_greater_than", :max_length => self.question.max_length))
      end
    end
  end
end

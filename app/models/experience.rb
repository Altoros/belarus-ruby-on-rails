class Experience < ActiveRecord::Base
  validates :level, presence: true
  validates :level, uniqueness: true
  validates :level, length: { maximum: 25 }

  has_many :profiles

  def translated_level(prefix = nil)
    I18n.t(id, scope: 'experience.levels', default: level, locale: prefix)
  end
end

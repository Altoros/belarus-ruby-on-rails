class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, length: { maximum: 255 }
  validates :title, presence: true
  validates :content, presence: true
  has_many :comments, dependent: :delete_all

  belongs_to :user
  belongs_to :meetup
  validates_associated :user
  scope :published, ->{ where(published: true) }
  scope :internal, ->{ where('rss_link IS NULL') }
  scope :meetuped, ->{ where('meetup_id IS NOT NULL') }

  def normalize_friendly_id(text)
    text.to_slug.normalize! transliterations: :russian if text
  end
end

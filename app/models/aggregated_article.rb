class AggregatedArticle < Article
  validates :rss_link, :presence => true
  default_scope :conditions => 'rss_link IS NOT NULL'
end

class AggregatedArticle < Article
  validates :rss_link, presence: true
  default_scope { where('rss_link IS NOT NULL') }
end

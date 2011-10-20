class AgregatedArticle < Article
  validates :rss_link, :presence => true
end

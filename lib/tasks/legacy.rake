namespace :legacy do
  desc "Import the legacy data."
  task :import => :environment do
    #Import custom news
    LegacyArticle.where(:catid => 2, :state => 1).each { |article|
      slug = LegacyRedirection.where(
        :newurl => 'index.php?option=com_content&id=' + article.id.to_s + '&task=view'
      ).first.oldurl
      Article.create(
        :title => article.title,
        :content => article.introtext,
        :published => true,
        :created_at => article.created,
        :updated_at => article.modified,
        :slug => slug
      )
    }

    #Import aggregated news
    LegacyArticle.where(:catid => 1, :state => 1).each { |article|
      slug = LegacyRedirection.where(
        :newurl => 'index.php?option=com_content&id=' + article.id.to_s + '&task=view'
      ).first.oldurl
      rss_link_attribute = article.fulltext.scan(/href="(.*?)"/) if article.fulltext
      rss_link = rss_link_attribute[0][0] if rss_link_attribute.count > 0
      complex_rss_link = rss_link.scan(/&url=(.*?)&cid/) if rss_link
      rss_link = complex_rss_link[0][0] if complex_rss_link && complex_rss_link.count > 0
      if rss_link && rss_link.scan(/^http/i).count > 0
        AggregatedArticle.create(
          :title => article.title,
          :content => article.introtext
                        .gsub(/<i.*?<\/i>/, '')
                        .gsub(/<img.*?>/, '')
                        .gsub(/<.*?>/, '')
                        .strip,
          :published => true,
          :created_at => article.created,
          :updated_at => article.modified,
          :rss_link => rss_link,
          :slug => slug
        )
      end
    }
  end
end

class Legacy < ActiveRecord::Base
  config = YAML::load(File.open('config/database.yml'))
  establish_connection config['legacy']
end

class LegacyArticle < Legacy
  set_table_name 'rug_content'
end

class LegacyRedirection < Legacy
  set_table_name 'rug_redirection'
end

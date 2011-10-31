# encoding: UTF-8
require 'feedzirra'

namespace 'aggregator' do

  desc 'Add new articles from rss to database'
  task :collect => :environment do
    config = AggregatorConfiguration.first
    if !config || config.source.empty?
      raise 'Not found config. Try run rake:db:seed.'
    end

    #getting feed_object from database
    feed_object = config.feed_object

    #check if we have same url in feedzirra
    if feed_object && feed_object.feed_url == config.source
      #updating feed
      feed_object = Feedzirra::Feed.update(feed_object)

      #check if feed has been updated since last running this rake task
      if !feed_object.has_new_entries?
        exit 0
      end

      new_entries = feed_object.new_entries
    else
      feed_object = Feedzirra::Feed.fetch_and_parse(config.source)

      new_entries = feed_object.entries
    end

    #now let's put all new entries to database
    new_entries.each { |entry|
      rss_link = entry.url
      complex_rss_link = rss_link.scan(/&url=(.*?)$/)
      if complex_rss_link && complex_rss_link.count > 0
        rss_link = complex_rss_link[0][0]
      end
      AggregatedArticle.create(
        :title => entry.title.gsub(%r{</?[^>]+?>}, ''),
        :content => entry.summary.gsub(%r{</?[^>]+?>}, '')
                                 .gsub('и другие&nbsp;&raquo;', ''),
        :rss_link => rss_link,
        :published => true,
        :created_at => entry.published
      )
    }

    #put updated feed_object back to database
    AggregatorConfiguration.first.update_attributes(
      :feed_object => feed_object
    )
  end

  task :default => ['collect']
end

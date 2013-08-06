class Video < ActiveRecord::Base
  attr_accessible :title, :description, :content, :published_at
  validates_presence_of :title, :published_at, :content

  def self.screening(fetched_videos)
  	videos = []
  	contents = pluck :content

  	fetched_videos.each do |video|
  	  videos.push(video) unless contents.include?(video.media_content.first.url)
  	end
  	videos
  end
end

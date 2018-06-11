class Video < ActiveRecord::Base
  validates_presence_of :title, :published_at, :content

  class << self
    def screening(fetched_videos)
      videos = []
      contents = pluck :content

      fetched_videos.each do |video|
        videos.push(video) unless contents.include?(video.media_content.first.url)
      end
      videos
    end

    def add_videos(fetched_videos_params)
      fetched_videos_params.each { |params| Video.create(eval(params)) }
    end
  end
end

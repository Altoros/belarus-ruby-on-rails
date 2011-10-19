module TwitterBlocksHelper
  def twitter_blocks_settings
    TwitterBlock.find(:all)
  end

  def twitter_blocks
    html = ''
    TwitterBlock.find(:all).each do |block|
      html << '<div class="twtr-search-widget" id="twtr-search-widget-' + block.id.to_s + '"></div>'
    end

    html.html_safe
  end
end

module TwitterBlocksHelper
  def twitter_blocks_settings
    TwitterBlock.find(:all)
  end

  def twitter_blocks
    html = ''
    TwitterBlock.all.each do |block|
      html << '<div id="twtr-search-widget-' + block.id.to_s + '">' + block.widget + '</div>'
    end

    html.html_safe
  end
end

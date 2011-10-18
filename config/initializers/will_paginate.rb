require 'will_paginate'
require 'will_paginate/view_helpers'
require 'will_paginate/view_helpers/link_renderer'

module WillPaginate
  module ActionView
    include ViewHelpers
    def will_paginate(collection = nil, options = {})
      options, collection = collection, nil if collection.is_a? Hash
      collection ||= infer_collection_from_controller

      options = options.symbolize_keys
      options[:renderer] = PaginationListLinkRenderer

      super(collection, options).try(:html_safe)
    end
  end
end

class PaginationListLinkRenderer < WillPaginate::ActionView::LinkRenderer

  protected

    def page_number(page)
      unless page == current_page
        link(tag(:span, page), page)
      else
        link(tag(:span, page), page, :class => 'act')
      end
    end

    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      previous_or_next_page(num, '', 'prev')
    end

    def next_page
      num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
      previous_or_next_page(num, '', 'next')
    end

    def previous_or_next_page(page, text, classname)
      if page
        link(text, page, :class => classname)
      else
        tag(:span, '', :class => classname)
      end
    end

end
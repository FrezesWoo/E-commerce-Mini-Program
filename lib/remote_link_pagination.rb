module RemoteLinkPagination
  class LinkRenderer < BootstrapPagination::Rails
    def html_container(html)
      tag :ul, html, container_attributes, :class => "pagination justify-content-center"
    end

    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page), :class => 'page-link'), :class => "page-item #{'active' if page == current_page}"
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end

    def ul_class
      ["pagination", "justify-content-center"].compact.join(" ")
    end
  end
end

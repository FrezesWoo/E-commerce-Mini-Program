include ActionView::Helpers::UrlHelper

module ApplicationHelper
  def alternate_locales
    I18n.available_locales.map{|l|
      yield(l)
    }.join.html_safe
  end

  def get_proper_flag(lang)
    tab = {
      'fr': 'fr',
      'en': 'gb',
      'zh-CN': 'cn'
    }
    tab[lang]
  end

  def get_proper_name(lang)
    tab = {
      'fr': 'Français',
      'en': 'English',
      'zh-CN': '中文'
    }
    tab[lang]
  end

  def glyph(*names)
    content_tag :i, nil, class: names.map{|name| "icon-#{name.to_s.gsub('_','-')}" }
  end

  def is_current(path)
    return request.path.include?(path) ? 'active' : ''
  end

  def get_proper_picture(form)
    return !form.object.image.url.include?('missing') ? form.object.image.url : "/image-placeholder.jpg"
  end

  def get_field_image(form, field)
    return !form.object.send(field).url.include?('missing') ? form.object.send(field).url : "/image-placeholder.jpg"
  end

  def clear_cache
    Rails.cache.delete("product_categories")
    Rails.cache.delete("package_categories")
    Rails.cache.delete_matched("page_*")
  end
end

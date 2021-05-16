module PagesHelper
  def all_template_class(numbers=[])
    templates = []
    numbers.each do |n|
      templates.push(n.class == Integer ? "template#{n}" : n)
    end
    return templates.join(' ')
  end

  def is_current_template(numbers=[], current_template)
    templates = []
    numbers.each do |n|
      templates.push(n.class == Integer ? "template#{n}" : n)
    end
    if current_template.nil? || !templates.include?(current_template)
      ''
    else
      'show-fields'
    end
  end

  def all_classes(numbers=[], current_template)
    return "#{is_current_template(numbers, current_template)} #{all_template_class(numbers)}"
  end

  def pick_proper_template(template)
    temp = template.class == Integer ? "template#{template}" : template
    return temp
  end
end

module ApplicationHelper
  def code_mirror(field_name, value=nil, options={})
    text_area_tag(field_name, value, options.merge(:class => 'code-mirror-placeholder'))
  end

  def readonly_code_mirror(field_name, value=nil, options={})
    code_mirror(field_name, value, options.merge(:'data-readonly' => 'nocursor'))
  end

  def link_to_record(record, text=record.name)
    link_to(text, record)
  end

  def action_link(text, path, options={})
    link_to(text, path, options_with_class(options, 'action'))
  end

  def disabled_link(text, options={})
    link_to(text, 'javascript:void(0);', options_with_class(options, 'disabled-link'))
  end

  def options_with_class(options, class_name)
    options.merge(:class => [*options[:class], class_name].join(' '))
  end
end

module ApplicationHelper
  def code_mirror(field_name, value=nil, options={})
    text_area_tag(field_name, value, options.merge(:class => 'code-mirror-placeholder'))
  end

  def readonly_code_mirror(field_name, value=nil, options={})
    code_mirror(field_name, value, options.merge(:'data-readonly' => 'nocursor'))
  end

  def disabled_link(text, options={})
    class_list = [*options[:class], 'disabled-link'].join(' ')
    link_to(text, 'javascript:void(0);', options.merge(:class => class_list))
  end
end

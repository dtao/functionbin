module ApplicationHelper
  def nav_menu
    render(:partial => 'partials/navigation')
  end

  def site_footer
    render(:partial => 'partials/site_footer')
  end

  def about_info
    render(:partial => 'partials/about_info')
  end

  def edit_form(record)
    preserve(render(:partial => "#{record.class.table_name}/form"))
  end

  def code_mirror(field_name, value=nil, options={})
    text_area_tag(field_name, value, options_with_class(options, 'code-mirror-placeholder'))
  end

  def readonly_code_mirror(field_name, value=nil, options={})
    code_mirror(field_name, value, options.merge(:'data-readonly' => 'nocursor'))
  end

  def table_filter(type, property, cell_selector='td:first-child')
    render(:partial => 'partials/table_filter', :locals => {
      :type => type,
      :property => property,
      :cell_selector => cell_selector
    })
  end

  def profile_image(user, size=50)
    gravatar_image_tag(user.email, :gravatar => { :size => size })
  end

  def link_to_record(record, text=record.name)
    link_to(text, record)
  end

  def versions_link(implementation)
    return nil if implementation.versions.count < 1
    link_to(pluralize(implementation.versions.count + 1, 'version'), implementation_versions_path(implementation), {
      :class => 'versions'
    })
  end

  def action_link(text, path, options={})
    link_to(text, path, options_with_class(options, 'action'))
  end

  def back_link(text='Back', path=root_path, options={})
    link_to(text, path, options_with_class(options, 'back-link'))
  end

  def disabled_link(text, options={})
    link_to(text, 'javascript:void(0);', options_with_class(options, 'disabled-link'))
  end

  def options_with_class(options, class_name)
    options.merge(:class => [*options[:class], class_name].join(' '))
  end

  def timestamp(record)
    time_ago_in_words(record.created_at) + ' ago'
  end
end

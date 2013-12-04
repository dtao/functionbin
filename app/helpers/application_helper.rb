module FunctionBin
  module ApplicationHelper
    def code_mirror(field_name, options={})
      text_area_tag(field_name, options.merge(:class => 'code-mirror-placeholder'))
    end
  end

  self::App.helpers { include ApplicationHelper }
end

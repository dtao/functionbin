module FunctionBin
  module ApplicationHelper
    def code_mirror(field_name, options={})
      if options.include?(:value)
        options[:value] = preserve(options[:value])
      end

      text_area_tag(field_name, options.merge(:class => 'code-mirror-placeholder'))
    end

    def readonly_code_mirror(field_name, options={})
      code_mirror(field_name, options.merge(:'data-readonly' => 'nocursor'))
    end
  end

  self::App.helpers { include ApplicationHelper }
end

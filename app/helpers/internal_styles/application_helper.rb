module InternalStyles
  module ApplicationHelper
    def title(value = nil, &block)
      if block_given?
        raise ArgumentError, '`title` requires a title or a block' unless value.nil?
        content_for(:title, &block)
      else
        raise ArgumentError, '`title` requires a title or a block' if value.nil?
        content_for(:title) { value }
      end
    end

    def header_button(label, href, options = {})
      class_name = options[:class] || 'secondary'

      options[:class] = 'btn btn-sm'
      options[:class] += " btn-outline-#{class_name}"

      content_for(:header_actions) do
        link_to(label, href, options)
      end
    end
  end
end

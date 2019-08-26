module InternalStyles
  include CardHelper
  include ListHelper

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

    def title?
      content_for?(:title)
    end

    def header_button(label, href, options = {})
      class_name = options[:class] || 'secondary'

      options[:class] = 'btn btn-sm'
      options[:class] += " btn-outline-#{class_name}"

      content_for(:header_actions) do
        link_to(label, href, options)
      end
    end

    def dl(pairs, **options)
      content_tag(:dl, **options) do
        safe_join(pairs.flat_map do |k,v|
          [content_tag(:dt, k), content_tag(:dd, v)]
        end)
      end
    end

    def errors_for(record)
      content_tag(:ul, class: 'errors') do
        safe_join(record.errors.full_messages.map do |message|
          content_tag(:li, message)
        end)
      end
    end
  end
end

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

    ##
    # Generate a <tt><dl></tt> for the given hash of keys (terms) and values (definitions)
    #
    # ==== Signatures
    #
    #    dl(key1 => value1, key2 => value2, ..., options = {})
    #
    # ==== Options
    #
    # All options are passed directly to the outer +content_tag+ that generates the <tt><dl></tl> element.
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

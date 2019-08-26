module InternalStyles
  module ListHelper
    def card_list_group(header, records, **options, &block)
      if records.none?
        return card(header, **options) do
          content_tag(:p, 'No Content', class: 'empty-card mb-0 ')
        end
      end

      options[:class] = ['list-group-flush'] + Array.wrap(options[:classes])

      body_proc = Proc.new { list_group(records, options, &block) }
      card(header, body_proc: body_proc)
    end

    def list_group(records, **options, &block)
      classes = ['list-group'] + Array.wrap(options[:class])
      block ||= Proc.new { |record| render record }

      content_tag(:ul, class: classes) do
        safe_join(records.map do |record|
          content_tag(:li, id: dom_id(record), class: "list-group-item #{dom_class(record)}") do
            block.call(record)
          end
        end)
      end
    end
  end
end
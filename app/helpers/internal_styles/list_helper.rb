module InternalStyles
  module ListHelper
    ##
    # Generate a Bootstrap card list group for the given records. The records are iterated over,
    # and yielded to the block.
    #
    # Effectively this wraps a list_group in a card, and adds the <tt>list-group-flush</tt> class
    # to the list group.
    #
    # See https://getbootstrap.com/docs/4.0/components/card/#list-groups
    #
    # ==== Signatures
    #
    #    card_list_group(header, record, options = {}) do |record|
    #      # list-group-item content
    #    end
    #
    # ==== Options
    # * <tt>:class</tt> - Classes applied to the list group element
    #
    # ==== Examples
    # Generating a list for an array of ActiveRecord objects
    #
    #    <%= card_list_group('Users', User.all) do |user| %>
    #      <h1><%= user.name %></h1>
    #      <p><%= user.email %></p>
    #    <% end %>
    #    # => <div class="card">
    #           <div class="card-header">
    #             Users
    #           </div>
    #           <div class="list-group list-group-flush">
    #             <div class="list-group-item">
    #               <h1>John Smith</h1>
    #               <p>jsmith@gmail.com</p>
    #             </div>
    #             <!-- ... -->
    #           </div>
    #         </div>
    def card_list_group(header, records, **options, &block)
      if records.none?
        return card(header, **options) do
          content_tag(:p, 'No Content', class: 'empty-card mb-0 ')
        end
      end

      list_group_options = { class: ['list-group-flush'] + Array.wrap(options[:list_classes]) }

      options[:body_proc] = Proc.new { list_group(records, **list_group_options, &block) }
      card(header, **options)
    end

    def card_linked_list_group(header, records, **options, &block)
      if records.none?
        return card(header, **options) do
          content_tag(:p, 'No Content', class: 'empty-card mb-0 ')
        end
      end

      list_group_options = {
        class: ['list-group-flush'] + Array.wrap(options[:list_classes]),
        href: options[:href]
      }

      options[:body_proc] = Proc.new { linked_list_group(records, **list_group_options, &block) }
      card(header, **options)
    end

    ##
    # Geneate a Bootstrap list group for the given records.
    #
    # Each list-group-item has its ID and class set via <tt>dom_id</tt> and
    # <tt>dom_class</tt> respectively, meaning the records must respond to <tt>to_key</tt>.
    #
    # ==== Signatures
    #
    #   list_group(records, **options) do |record|
    #     # list-group-item content
    #   end
    #
    # ==== Options
    # * <tt>:class</tt> - Classes to apply to the <tt><div class="list-group"></tt> container
    #
    # ==== Examples
    # Generating a list-group from an array of integers
    #
    #    <%= list_group(User.all) do |user| %>
    #      <b><%= user.name%></b>
    #    <% end %>
    #    # => <div class="list-group">
    #           <div id="user_1" class="list-group-item user">
    #             <b>John</b>
    #           </div>
    #           <div id="user_2" class="list-group-item user">
    #             <b>Sam</b>
    #           </div>
    #           <div id="user_3" class="list-group-item user">
    #             <b>Jill</b>
    #           </div>
    #         </div>
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

    def linked_list_group(records, **options, &block)
      classes = ['list-group'] + Array.wrap(options[:class])
      block ||= Proc.new { |record| render record }
      href = options[:href] || Proc.new { |record| url_for record }

      content_tag(:div, class: classes) do
        safe_join(records.map do |record|
          content_tag(:a, href: href.call(record), id: dom_id(record), class: "list-group-item list-group-item-action #{dom_class(record)}") do
            block.call(record)
          end
        end)
      end
    end
  end
end
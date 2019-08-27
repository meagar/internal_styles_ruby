module InternalStyles
  module CardHelper
    ##
    # Generate a Bootstrap card with the given header
    #
    # ==== Signatures
    #
    #   # with a header
    #   card(header, options = {}) do
    #     # card body
    #   end
    #
    #   # with no header
    #   card(options = {}) do
    #     # card body
    #   end
    #
    # ==== Options
    # * <tt>:id</tt> - The ID of the outer <div class="card"> element
    # * <tt>:class</tt> - Additional classes to add to the <div class="card"> element
    # * <tt>:body_class</tt> - Additional classes to add to the <div class="card-body"> element
    # * <tt>:header_class</tt> - Additional classes to add to the <div class="card-header"> element
    #
    # ==== Examples
    # Generating a simple card with a header:
    #
    #   <%= card('Test Card') do %>
    #     This is the body of the test card
    #   <% end %>
    #   # => <div class="card">
    #          <div class="card-header">
    #            Test Card
    #          </div>
    #          <div class="card-body">
    #            This is the body of the test card
    #          </div>
    #        </div>
    #
    # A Card with no header
    #
    #   <%= card do %>
    #     Test Body
    #   <% end %>
    #   # => <div class="card">
    #          <div class="card-body">
    #            Test Body
    #          </div>
    #        </div>
    def card(header = nil, **options, &block)
      if header.is_a?(Hash) && options.empty?
        options = header
        header = nil
      end

      classes = Array.wrap(options[:class])
      header_classes = ['card-header'] + Array.wrap(options[:header_class])
      body_classes = ['card-body'] + Array.wrap(options[:body_class])

      id = options[:id]

      body_proc = options[:body_proc] || Proc.new do |body_classes|
        content_tag(:div, class: body_classes, &block)
      end

      card_tag(id: id, class: classes) do
        buffer = []
        buffer << content_tag(:div, header, class: header_classes) if header
        buffer << body_proc.call(body_classes)

        safe_join(buffer)
      end
    end

    ##
    # Generate a Bootstrap Card tag in the form <tt><div class="card"></tt>
    #
    # ==== Signatures
    #
    #  card_tag(**options) do
    #    # content for card
    #  end
    #
    # ==== Options
    # The <tt>options</tt> argument is passed directly through to <tt>content_tag</tt>,
    # see https://api.rubyonrails.org/classes/ActionView/Helpers/TagHelper.html#method-i-content_tag.
    #
    # The sole exception is that the <tt>:class</tt> option (if any) has the bootstrap class
    # <tt>card</tt> added to it.
    #
    # ==== Examples
    #
    # Card with default options:
    #
    #   <%= card_tag do %>
    #     <p>Card content</p>
    #   <% end %>
    #   # => <div class="card">
    #          <p>Card content</p>
    #        </div>
    #
    # Card with additional options (note <tt>card</tt> is still added to the class list):
    #
    #   <%= card_tag(id: 'my-card', class: 'large-card') do %>
    #     <p>Card content</p>
    #   <% end %>
    #   # => <div id="my-card" class="card large-card">
    #          <p>Card content</p>
    #        </div>
    def card_tag(**options, &block)
      options[:class] = ['card'] + Array.wrap(options[:class])
      content_tag(:div, **options, &block)
    end

    ##
    # Generate a card for the given record, automatically populating the <tt>id</tt> and <tt>class</tt> attribute
    # using <tt>dom_id</tt> and <tt>dom_class</tt> respectively.
    #
    # ==== Signatures
    #
    #    # with a header
    #    card_for(record, header, options = {}) do
    #      # card body
    #    end
    #
    #    # with no header
    #    card_for(record, options = {}) do
    #      # card body
    #    end
    #
    # ==== Options
    # See +card+
    #
    # ==== Examples
    # Given a record of type <tt>ProdigyUser</tt>, with an id of <tt>123</tt> and name of <tt>"Jane"</tt>
    #
    #    <%= card_for(user, 'User Info') do %>
    #       This user's name is <%= user.name %>
    #    <% end %>
    #    # => <div id="prodigy_user_123" class="card prodigy_user">
    #           <div class="card-header">
    #             User Info
    #           </div>
    #           <div class="card-body">
    #             This user's name is Jane
    #           </div>
    #         </div>
    def card_for(record, header = nil, **options, &block)
      raise unless block_given?
      if header.is_a?(Hash) && options.empty?
        options = header
        header = nil
      end

      options[:id] = options.fetch(:id, dom_id(record))
      options[:class] = [dom_class(record)] + Array.wrap(options[:class])

      card(header, **options, &block)
    end
  end
end


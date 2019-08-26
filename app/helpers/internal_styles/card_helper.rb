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

      classes = ['card mb-3'] + Array.wrap(options[:class])
      header_classes = ['card-header'] + Array.wrap(options[:header_class])
      body_classes = ['card-body'] + Array.wrap(options[:body_class])

      id = options[:id]

      body_proc = options[:body_proc] || Proc.new do |body_classes|
        content_tag(:div, class: body_classes, &block)
      end

      content_tag(:div, class: classes, id: id) do
        buffer = []
        buffer << content_tag(:div, header, class: header_classes) if header
        buffer << body_proc.call(body_classes)

        safe_join(buffer)
      end
    end

    # Generate a card for the given record, automatically populating the `id` and `class` attribute
    # using `dom_id` and `dom_class` respectively.
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
    # Given a record of type `ProdigyUser`, with an id of `123` and name of "Jane"
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


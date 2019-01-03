# frozen_string_literal: true

module InternalStyles
  class Config
    def nav(&block)
      @nav_block = block if block_given?
    end

    def nav_items
      if @nav_block
        @nav_items ||= Rails.application.routes.url_helpers.instance_eval(&@nav_block)
      end

      @nav_items || []
    end
  end

  def self.configure
    @config ||= Config.new
    yield @config if block_given?
  end

  def self.config
    @config
  end
end

# frozen_string_literal: true

module InternalStyles
  class MissingConfigError < StandardError
    def message
      "InternalStyles.configure has not been called. Please run `rails generate internal_styles:install`"
    end
  end

  class Config
    def nav(&block)
      @nav_block = block if block_given?
    end

    def nav_helper
      return @nav if @nav

      @nav = InternalStyles::NavHelper.new

      if @nav_block
        Rails.application.routes.url_helpers.instance_exec(@nav, &@nav_block)
      end

      @nav
    end
  end

  def self.configure
    @config ||= Config.new
    yield @config if block_given?
  end

  def self.config
    raise InternalStyles::MissingConfigError if @config.nil?

    @config
  end
end

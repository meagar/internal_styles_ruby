# frozen_string_literal: true

module InternalStyles
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
    @config
  end
end

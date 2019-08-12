module InternalStyles
  class NavHelper
    attr_reader :items, :sub_navs, :options

    class Item < Struct.new(:label, :icon, :uri, :options) do
        def active?(current_path)
          current_path.starts_with?(uri)
        end
      end
    end

    def initialize(options = {})
      @items = []
      @sub_navs = {}
      @options = options
    end

    def item(name, icon, path, options = {})
      items << Item.new(name, icon, path, options)
    end

    def sub_nav(name, options = {})
      sub_navs[name] ||= NavHelper.new(options)
      yield sub_navs[name]
    end
  end
end
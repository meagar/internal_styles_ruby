module InternalStyles
  class NavHelper
    attr_reader :items, :sub_navs

    def initialize()
      @items = []
      @sub_navs = {}
    end

    def item(name, icon, path)
      items << [name, icon, path]
    end

    def sub_nav(name)
      sub_navs[name] ||= NavHelper.new
      yield sub_navs[name]
    end
  end
end
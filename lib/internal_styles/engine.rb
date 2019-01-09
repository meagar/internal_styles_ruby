module InternalStyles
  class Engine < ::Rails::Engine
    isolate_namespace InternalStyles

    require 'bootstrap/engine'
    require 'font-awesome-rails'
  end
end

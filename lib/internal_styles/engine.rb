module InternalStyles
  class Engine < ::Rails::Engine
    isolate_namespace InternalStyles

    require 'bootstrap/engine'
    require 'font-awesome-rails'
    require 'jquery-rails'
    require 'popper_js'
  end
end

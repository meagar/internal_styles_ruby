class InternalStyles::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)
  def create_initializers
    copy_file "initializer.rb", "config/initializers/internal_styles.rb"
    copy_file "applicaiton.html.erb", "app/views/layouts/application.html.erb"

    puts "Now add the following to the top of your application.css manifest"
    puts "//= require internal_styles/application to application.css"
  end
end

class InternalStyles::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)
  def create_initializers
    copy_file "initializer.rb", "config/initializers/internal_styles.rb"
  end
end

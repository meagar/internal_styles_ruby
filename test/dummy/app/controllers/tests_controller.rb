
class TestsController < ApplicationController

  helper_method :test_case

  private

  def test_case(title, template = nil)
    template ||= title.gsub(/^#/, '').parameterize.underscore
    template_path = "#{controller_name}/#{action_name}/#{template}.html.erb"
    source = File.read(Rails.root.join('app', 'views', template_path))
    output =  render_to_string(template: template_path, layout: nil)
    render_to_string(partial: 'test_case', locals: { title: title, output: output, source: source } )
  end
end
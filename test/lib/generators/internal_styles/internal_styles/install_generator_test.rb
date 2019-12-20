require 'test_helper'
require 'generators/internal_styles/install/install_generator'

module InternalStyles
  class InternalStyles::InstallGeneratorTest < Rails::Generators::TestCase
    tests InternalStyles::InstallGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    test "generator runs without errors" do
      assert_nothing_raised do
        run_generator ["arguments"]
      end
    end
  end
end

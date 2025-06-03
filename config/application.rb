require_relative 'boot'

require 'rails/all'
require 'csv'
require 'logger'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wordlog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    # Fix the bug that images are deleted when update post
    config.active_storage.multiple_file_field_include_hidden = false
    
    config.generators do |g|
      g.assets false # CSS, JavaScript files are not created automatically.
      g.helper false # helper file is not created.
      g.test_framework :rspec, # 5 lines added
      fixtures: false, # Skip creating the fixture to record in Test db.
      view_specs: false, # Do not create a spec for the view files
      helper_specs: false, # Do not create a spec for the helper file
      routing_specs: false # Do not create a spec for the routes.rb
    end
  end
end

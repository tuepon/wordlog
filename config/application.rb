require_relative "boot"

require "rails/all"
require "csv"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wordlog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.generators do |g| # add from here
      g.assets false          # CSS, JavaScript files are not created automatically.
      g.helper     false      # helper file is not created.
      g.test_framework :rspec, # 5 lines added
        fixtures: false, # テストDBにレコードを作るfixtureの作成をスキップ(FactoryBotを使用するため)
        view_specs: false, # ビューファイル用のスペックを作成しない
        helper_specs: false, # ヘルパーファイル用のスペックを作成しない
        routing_specs: false # routes.rb用のスペックファイル作成しない
    end  # add to here
  end
end

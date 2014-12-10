# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'simplecov'
require 'simplecov-rcov'
require 'coveralls'

SimpleCov.merge_timeout 3600
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::RcovFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

ENV['RAILS_ENV'] = 'cucumber'

require 'cucumber/rails'

# Refresh jetty data before cucumber tests run
if Rails.env.cucumber?
  begin
    WebMock.allow_net_connect!
    Nyucore.destroy_all
    Ichabod::DataLoader.new('spatial_data_repository', File.join(Rails.root, 'ingest/test_sdr.xml')).load
    Ichabod::DataLoader.new('lib_guides', File.join(Rails.root, 'ingest/test_libguides.xml')).load
    Ichabod::DataLoader.new('faculty_digital_archive_ngo','https://archive.nyu.edu/request','hdl_2451_33605',5).load
    # Loaded the voice collection up to record a cassette, but don't need it after that
    # Ichabod::DataLoader.new('voice', ENV['ICHABOD_VOICE_ENDPOINT_URL']).load
    Ichabod::DataLoader.new('archive_it_accw','https://archive-it.org').load
    # Loaded the NYUPress collection up to record a cassette, but don't need it after that
    Ichabod::DataLoader.new('nyu_press_open_access_book', 'http://discovery.dlib.nyu.edu:8080/solr3_discovery/nyupress/select','0','5').load

  ensure
    WebMock.disable_net_connect!
  end
end

# Capybara defaults to CSS3 selectors rather than XPath.
# If you'd prefer to use XPath, just uncomment this line and adjust any
# selectors in your step definitions to use the XPath syntax.
# Capybara.default_selector = :xpath

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     # { :except => [:widgets] } may not do what you expect here
#     # as Cucumber::Rails::Database.javascript_strategy overrides
#     # this setting.
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end

Before do
  if Capybara.default_driver == :selenium
    Capybara.current_session.driver.browser.manage.window.resize_to(1280, 1024)
  end
end

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation

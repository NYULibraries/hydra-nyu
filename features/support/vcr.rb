require 'vcr'

VCR.configure do |c|
  c.default_cassette_options = { :record => :new_episodes }
  c.hook_into :webmock
  c.cassette_library_dir     = 'features/cassettes'
end

VCR.cucumber_tags do |t|
  t.tag  '@vcr', :use_scenario_name => true
end

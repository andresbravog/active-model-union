$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start
require 'coveralls'
Coveralls.wear!
require 'rspec'
require 'rack/test'
require 'webmock/rspec'
require 'active_model_union'

RSpec.configure do |config|
  config.include WebMock::API
  config.include Rack::Test::Methods
end

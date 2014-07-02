$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
$:.unshift File.expand_path('models', __FILE__)

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'simplecov'
SimpleCov.start

require 'rspec'
require 'rack/test'
require 'webmock/rspec'
require 'active_model_union'
require 'arel'
require 'pry'

Dir[File.expand_path('../models/**/*.rb', __FILE__)].each {|file| require file }

RSpec.configure do |config|
  config.include WebMock::API
  config.include Rack::Test::Methods
end

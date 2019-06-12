ENV["TEST"] = "1"
ENV["JETS_ENV"] ||= "test"
# Ensures aws api never called. Fixture home folder does not contain ~/.aws/credentails
ENV['HOME'] = "spec/fixtures/home"

require "byebug"
require "fileutils"
require "jets"
require 'solid_use_case'
require 'solid_use_case/rspec_matchers'

abort("The Jets environment is running in production mode!") if Jets.env == "production"
Jets.boot

require "jets/spec_helpers"

Dir[Jets.root.join('spec/support/**/*.rb')].each { |f| require f }

module Helpers
  def payload(name)
    JSON.load(IO.read("spec/fixtures/payloads/#{name}.json"))
  end

  def json_response
    JSON.parse(response.body)
  end
end

RSpec.configure do |c|
  c.include Helpers
  c.include SolidUseCase::RSpecMatchers

  c.include FactoryBot::Syntax::Methods
  c.before(:suite) do
    FactoryBot.find_definitions
  end
end

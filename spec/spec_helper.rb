$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'
require "bundler"
Bundler.setup(:default, :development)
require 'selenium_multi_browser'
require 'rspec'
include SeleniumMultiBrowser

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end

class MockBrowser
  #How odd that the usual mock(:browser) does not work for at_exit calls
  def quit
  end
end
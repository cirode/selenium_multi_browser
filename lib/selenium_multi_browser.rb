require 'lazy'
require 'selenium-webdriver'
module SeleniumMultiBrowser
  def for_each_browser(browser_names=[:chrome, :firefox], &block)
    previous_browser = nil
    at_exit do
      previous_browser.quit if previous_browser
    end
    browser_names.each do |browser_name|
      driver =  Lazy::Promise.new do 
        previous_browser.quit if previous_browser
        previous_browser = Selenium::WebDriver.for browser_name
      end
      block.call(driver, browser_name)
    end
  end
end
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SeleniumMultiBrowser do
  context "#for_each_browser" do
    let(:mock_browser_instance){ MockBrowser.new}
    
    
    it "should instansiate the browsers and quite them at the end"  do
      #yes I know this should be split up into multiple tests... unfortauntely I can't
      browsers = [:chrome]
      browsers.each_with_index do |i, index|
        mock_browser_instance.should_receive(:quit) if (index < browsers.size - 1) #the last browser gets quit at exit, not as part of this test
        Selenium::WebDriver.should_receive(:for).once.with(i).and_return(mock_browser_instance)
      end
      for_each_browser browsers do |browser_instance, browser_name|
        browsers.should include(browser_name)
        browser_instance.should === mock_browser_instance
      end
    end
    
    it "should default to running firefox and chrome" do
      Selenium::WebDriver.should_receive(:for).twice.and_return(mock_browser_instance)
      browsers = [:firefox, :chrome]
      for_each_browser do |browser_instance, browser_name|
        browsers.should include(browser_name)
        browser_instance.should_not be_nil
      end
    end
    
    it "should not instansiate the browsers unless the browser is actually used" do
      Selenium::WebDriver.should_receive(:for).once.and_return(mock_browser_instance)
      for_each_browser do |browser_instance, browser_name|
        browser_instance.should_not be_nil if browser_name == :firefox
      end
    end
    
    it "should only run the browsers that are passed in" do
      browsers = [:chrome]
      for_each_browser browsers do |browser_instance, browser_name|
        browser_name.should == browsers.first
      end
    end
  end
end

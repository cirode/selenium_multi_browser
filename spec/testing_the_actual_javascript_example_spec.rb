require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "test_js" do
  for_each_browser do |browser, browser_name|
    context "in #{browser_name}" do
      before do
        browser.get("file://#{File.join(File.dirname(__FILE__),'..','test_js', 'index.html')}")
      end
      it "should have an h1 with Dynamic Page" do
        browser.find_element(:xpath => '//h1').text.should == "Dynamic Page"
      end
      context "when I click on the click here anchor" do
        it "should say clicked here after a delay" do
          anchor = browser.find_element(:xpath => '//a')
          anchor.text.should_not == "clicked here"
          anchor.click
          wait = Selenium::WebDriver::Wait.new(:timeout => 3)
          wait.until {anchor.text == "clicked here"}
        end
      end
    end
  end
end
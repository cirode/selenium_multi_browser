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
    end
  end
end
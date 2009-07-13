require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe RCSS::Initializer do
  context "run" do
    it "should fill take a block that creates a configuration object that allows you to write attributes" do
      initializer = RCSS::Initializer.run do |config|
        config.css_root = File.join(File.dirname(__FILE__), "..", "fixtures", "app")
      end
      
      initializer.css_root.should == File.join(File.dirname(__FILE__), "..", "fixtures", "app")
    end
    
    it "should call the #build_css method" do
      mock_initializer = RCSS::Initializer.new
      mock_initializer.should_receive(:build_css)
      RCSS::Initializer.stub!(:new).and_return(mock_initializer)
      
      RCSS::Initializer.run do |config|
        config.css_root = "Blah blah blah"
      end
    end
  end
  
  context "build_css" do
    before(:each) do
      @stylesheets_path = File.join(File.dirname(__FILE__), "..", "fixtures", "public", "stylesheets")
    end
    
    it "should parse through each of the files in the css_root directory creating css output files in the output folder" do
      RCSS::Initializer.run do |config|
        config.css_root = File.join(File.dirname(__FILE__), "..", "fixtures", "app", "css")
        config.output_path = @stylesheets_path
      end
      
      entries = Dir.entries(@stylesheets_path)
      entries.should include("application.css")
      entries.should include("application")
      entries.should include("users")
      File.exist?(File.join(@stylesheets_path, "application", "layouts.css")).should be_true
      File.exist?(File.join(@stylesheets_path, "users", "admins.css"))
    end
    
    context "compress stylesheets" do
      it "should only create a file all.css" do
        RCSS::Initializer.run do |config|
          config.css_root = File.join(File.dirname(__FILE__), "..", "fixtures", "app", "css")
          config.output_path = @stylesheets_path
          config.compress = true
        end
      
        entries = Dir.entries(@stylesheets_path)
        entries.sort.should == [".", "..", "all.css"]
      end
    end
  end
end
require File.join(File.dirname(__FILE__), "spec_helper")

describe RCSS do
  context "#include_css" do
    it "should take an array of css names and return a string of the link tags" do
      RCSS.include_css(['global', 'application/standards']).should == <<-CSS
<link rel="stylesheet" type="text/css" href="/stylesheets/global.css" />
<link rel="stylesheet" type="text/css" href="/stylesheets/application/standards.css" />
CSS
    end
  end
end
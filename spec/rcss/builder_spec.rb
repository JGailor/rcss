require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe RCSS::Builder do
  context "#render" do
    it "should call #content" do
      builder = RCSS::Builder.new
      builder.should_receive(:content).and_return(an_instance_of(String))
      builder.render
    end
  end
  
  context "#style" do
    it "should create an RCSS::Style object with the outer selector as its context" do
      selector = "#project"
      RCSS::Style.should_receive(:new).with(selector)
      RCSS::Builder.new.style(selector) {|project_style| ;}
    end
  end
  
  context "to_s" do
    it "should generate the correct css" do
      selector = "#project"
      builder = RCSS::Builder.new
      builder.style(selector) do |project_style|
        project_style.height = "100px"
        project_style.width = "100px"
      end
      builder.to_s.should == "#project {\nheight: 100px;\nwidth: 100px;\n}\n"
    end
  end
  
  context "nested styles" do
    it "should generate the correct css for nested structures" do
      builder = RCSS::Builder.new
      builder.style("#project") do |project_style|
        project_style.style("#header") do |header_style|
          header_style.style("#navigation") do |nav_style|
            nav_style.width = "1000px"
          end
        end
      end
      
      builder.to_s.should == <<-CSS
#project #header #navigation {
width: 1000px;
}
CSS
    end
  end
end
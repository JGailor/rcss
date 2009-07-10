require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe RCSS::Style do
  context "#initialize" do
    it "should set the context value" do
      RCSS::Style.new("#project").instance_variable_get("@context".to_sym).should == "#project"
    end
  end
  
  context "#method_missing" do
    it "should add a property to an internal hash of styles if it is an assignment method" do
      style = RCSS::Style.new("#project")
      style.height = "100px"
      style.instance_variable_get("@properties".to_sym)["height"].should == "100px"
    end
  end
  
  context "#to_s" do
    it "should render out itself as a style" do
      style = RCSS::Style.new("#project")
      style.height = "100px"
      style.to_s.should == "#project {\nheight: 100px;\n}\n"
    end
  end
  
  context "nested styles" do
    context "to_s" do
      it "should render out the css correctly for a nested set of styles" do
        style = RCSS::Style.new("#project")
        style.height = "100px"
        style.style("#spacer") do |spacer_style|
          spacer_style.width = "1px"
        end
        
        style.to_s.should == <<-CSS
#project {
height: 100px;
}

#project #spacer {
width: 1px;
}
CSS
      end
    end
  end
  
  context "deep nesting" do
    context "to_s" do
      it "should render out the css correctly for a deeply nested set of styles" do
        style = RCSS::Style.new("#project")
        style.height = "100px"
        style.style("#header") do |header_style|
          header_style.width = "100px"
          header_style.style("#navigation") do |nav_style|
            nav_style.background_color = "red"
            nav_style.border_size = "1px"
          end
          header_style.style("#spacer") do |spacer_style|
            spacer_style.width = "1px"
          end
        end
        
        style.to_s.should == <<-CSS
#project {
height: 100px;
}

#project #header {
width: 100px;
}

#project #header #navigation {
background-color: red;
border-size: 1px;
}

#project #header #spacer {
width: 1px;
}
CSS
      end
    end
  end
end
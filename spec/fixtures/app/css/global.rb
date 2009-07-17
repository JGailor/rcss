module Css
  class Global < RCSS::Builder
    def content
      style("body") do |body_style|
        body_style.text_align = "left"
      end
    end
  end
end
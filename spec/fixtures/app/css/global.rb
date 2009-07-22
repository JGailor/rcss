module Css
  class Global < RCSS::Builder
    def content
      style("body") do
        text_align "left"
      end
    end
  end
end
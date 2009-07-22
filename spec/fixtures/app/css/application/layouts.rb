module Css
  module Application
    class Layouts < RCSS::Builder
      def content
        style("#layout") do
          style(".project") do
            width "1000px"
            height "100%"
        
            style("#header") do
              height = "200px"
            end
          end
        end
      end
    end
  end
end
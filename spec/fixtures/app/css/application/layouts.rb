module Css
  module Application
    class Layouts < RCSS::Builder
      def content
        style("#layout") do |layout_style|
          layout_style.style(".project") do |project_style|
            project_style.width = "1000px"
            project_style.height = "100%"
        
            project_style.style("#header") do |header_style|
              header_style.height = "200px"
            end
          end
        end
      end
    end
  end
end
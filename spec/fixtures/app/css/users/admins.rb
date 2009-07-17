module Css
  module Users
    class Admins < RCSS::Builder
      def content
        style("#admins") do |admin_style|
          admin_style.style("#header") do |header_style|
            header_style.height = "100px"
          end
        end
      end
    end
  end
end
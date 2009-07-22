module Css
  module Users
    class Admins < RCSS::Builder
      def content
        style("#admins") do
          style("#header") do
            height = "100px"
          end
        end
      end
    end
  end
end
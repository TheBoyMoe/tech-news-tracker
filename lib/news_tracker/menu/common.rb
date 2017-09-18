module NewsTracker
  module Menu
    # to be divided in public/private methods for clarity
    class Common

      def read_menu_command
        @command = $stdin.gets.chomp.strip.downcase
      end

      def build_article_list(array)
        str = ""
        array.each.with_index(1) do |article, i|
          str += "  #{i}. #{article.title}\n"
        end
        str.gsub(/\n$/, '')
      end

      def select_article_number(number)
        "Enter a number between 1-#{number} to view more detail"
      end

      def prompt_user_to_go_back
        "Type 'back' to return to the main menu"
      end

      def line_break
        "------------------------------------------------------------------"
      end

    end
  end

end

module NewsTracker
  module Menu
    class Main
      def initialize
        @command = nil
      end

      def display
        puts 'Display main menu options!'
      end

      def read_menu_command
        @command = $stdin.gets.strip.downcase
      end

      def process_command
        if is_list?
          # go to a list menu
          NewsTracker::Menu::List.new
        elsif is_archive?
          #
        else
          # not a valid command, so stay in the same menu
        end
      end

      private

      def is_list?
        @command == 'ruby' || @command == 'js' || @command == 'node'
      end

      def is_archive?
      end


    end
  end
end

module NewsTracker
  module Menu
    class Main
      def initialize
        @command = nil
      end

      def display
      end

      def read_menu_command
        @command = $stdin.gets.strip.downcase
      end

      def process_command
        if is_a_language?
          # go to a list menu
          NewsTracker::Menu::List.new
        elsif is_archive?
          #
        else
          # not a valid command, so stay in the same menu
        end
      end

      private

      def is_a_language?
        @command == 'ruby' || @command == 'js' || @command == 'node'
      end

      def is_archive?
      end
    end
  end
end

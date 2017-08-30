module NewsTracker
  module Menu
    class Main
      def initialize
        @command = nil
      end

      def display
        list_options
      end

      def read_menu_command
        @command = $stdin.gets.strip.downcase
      end

      def process_command
        if is_list?
          # display the latest ruby/js/node articles
          NewsTracker::Menu::List.new(@command)
        elsif is_archive?
          # display the archive list
          NewsTracker::Menu::Archive.new
        elsif @command == 'exit'
          # terminate app
          puts 'Goodbye!'
        else
          # not a valid command, so stay in the same menu
          puts 'Not a valid command'
          NewsTracker::Menu::Main.new
        end
      end

      private

      def is_list?
        @command == 'ruby' || @command == 'js' || @command == 'node'
      end

      def is_archive?
        @command == 'archive'
      end

      def list_options
        puts "------------------------------------------------------------------\n  Option menu:\n------------------------------------------------------------------\n  Select a topic to list the latest articles\n  Type 'ruby' for Ruby and Rails news\n  Type 'js' for Javascript news\n  Type 'node' for NodeJS news\n  Type 'archive' to view article archive\n  Type 'exit' to quit\n------------------------------------------------------------------\n"
      end

    end
  end
end

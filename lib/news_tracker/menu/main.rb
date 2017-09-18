require_relative './common'

module NewsTracker
  module Menu
    class Main < Common
      def initialize
        @command = nil
      end

      def display
        <<~HEREDOC
          ------------------------------------------------------------------
            Option menu:
          ------------------------------------------------------------------
            Select a topic to list the latest articles
            Type 'ruby' for Ruby and Rails news
            Type 'js' for Javascript news
            Type 'node' for NodeJS news
            Type 'archive' to view article archive
            Type 'exit' to quit
          ------------------------------------------------------------------
        HEREDOC
      end

      def process_command
        # validate user input(@command)
        if is_list?
          # display the latest ruby/js/node articles
          NewsTracker::Menu::List.new(@command)
        elsif is_archive?
          # display the archive list
          NewsTracker::Menu::Archive.new
        elsif @command == 'exit'
          # terminate app
          puts 'Goodbye!'
          exit
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

    end
  end
end

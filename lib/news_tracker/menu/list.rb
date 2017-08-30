module NewsTracker
  module Menu
    class List

      def initialize(command)
        @command = command
      end

      def display
        puts "Display the list of #{@command} articles"
      end

    end
  end
end

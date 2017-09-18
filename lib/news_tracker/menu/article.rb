require_relative "./common"

module NewsTracker
  module Menu
    class Article < Common

      def initialize(article_number)
        @article_number = article_number
      end

      def display
        # TODO return article string
        "Return an article string"
      end

      def process_command
        # TODO open or archive article
      end

    end
  end
end

require_relative "./common"

module NewsTracker
  module Menu
    class Archive < Common

      def display
        <<~HEREDOC
          #{line_break}
          #{opening_line}
          #{line_break}
          #{build_article_list(fetch_articles)}
          #{line_break}
          #{select_article_number(fetch_articles.size)}
          #{prompt_user_to_go_back}
          #{line_break}
        HEREDOC
      end

      def process_command
        # TODO

      end

      def fetch_articles
        NewsTracker::Article.fetch_archive
      end

      private
        def opening_line
          "Displaying list of archived articles"
        end

    end
  end
end

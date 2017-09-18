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
        if @command.to_i > 0 && @command.to_i <= fetch_articles.size
          NewsTracker::Menu::Article.new(@command, 'archive')
        elsif @command == 'back'
          NewsTracker::Menu::Main.new
        else
          self
        end
      end


      private
        def opening_line
          "Displaying list of archived articles"
        end

        def fetch_articles
          NewsTracker::Article.fetch_archive
        end

    end
  end
end

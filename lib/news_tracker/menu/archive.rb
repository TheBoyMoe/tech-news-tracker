module NewsTracker
  module Menu
    class Archive

      def display
        <<~HEREDOC
          #{line_break}
          #{opening_line}
          #{line_break}
          #{build_article_list}
          #{line_break}
          #{select_article_number}
          #{prompt_user_to_go_back}
          #{line_break}
        HEREDOC
      end

      def read_menu_command
        @command = $stdin.gets.strip.downcase
      end

      def process_command
        # TODO

      end

      private
        def build_article_list
          str = ""
          fetch_articles.each.with_index(1) do |article, i|
            str += "  #{i}. #{article.title}\n"
          end
          str.gsub(/\n$/, '')
        end

        def fetch_articles
          NewsTracker::Article.fetch_archive
        end

        def opening_line
          "Displaying list of archived articles"
        end

        def select_article_number
          "Enter a number between 1-#{fetch_articles.size} to view more detail"
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

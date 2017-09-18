require_relative "./common"

module NewsTracker
  module Menu
    class List < Common

      @@urls = [
        "http://rubyweekly.com/rss/16581bfg",
        "http://javascriptweekly.com/rss/221bj275",
        "https://nodeweekly.com/rss/"
      ]

      def initialize(list_type)
        # retrieve the articles & populate the article cache
        @list_type = list_type
        populate_article_cache
      end

      def display
        <<~HEREDOC
          #{line_break}
          #{opening_line}
          #{line_break}
          #{build_article_list(NewsTracker::Article.all)}
          #{line_break}
          #{select_article_number(NewsTracker::Article.all.size)}
          #{prompt_user_to_go_back}
          #{line_break}
        HEREDOC
      end

      def process_command
        if @command.to_i > 0 && @command.to_i <= NewsTracker::Article.all.size
          # return the article
          #NewsTracker::Article.all[@command.to_i - 1]
          NewsTracker::Menu::Article.new
        elsif @command == 'back'
          NewsTracker::Menu::Main.new
        else
          self
        end
      end

      private

        def rss_feed_url
          num = -1
          case @list_type
          when 'ruby'
            num = 0
          when 'js'
            num = 1
          when 'node'
            num = 2
          end
          num
        end

        def fetch_articles
          NewsTracker::RssFeed.new(@@urls[rss_feed_url]).create_article_instances_from_hashes
        end

        def populate_article_cache
          NewsTracker::Article.clear_all
          fetch_articles
        end

        def opening_line
          "Displaying #{@list_type} news:"
        end

    end
  end
end

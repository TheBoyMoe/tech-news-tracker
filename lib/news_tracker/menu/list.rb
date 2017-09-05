module NewsTracker
  module Menu
    class List

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
        # display the list of articles
        build_article_list.concat(prompt_user_to_select_article)
      end

      def read_menu_command
        @command = $stdin.gets.strip.downcase
      end

      def process_command
        # validate user input
          # - is it a number within range - select article or
          # - did the user  enter 'back'
          # - 'unknown' input
        if @command.to_i > 0 && @command.to_i <= NewsTracker::Article.all.size
          # return the article
          NewsTracker::Article.all[@command.to_i - 1]
        elsif @command == 'back'
          'back'
        else
          'unknown'
        end
      end


      def build_article_list
        str = "------------------------------------------------------------------\nDisplaying #{@list_type} news:\n------------------------------------------------------------------\n"
        NewsTracker::Article.all.each.with_index(1) do |article, i|
          str += "  #{i}. #{article.title}\n"
        end
        str += "------------------------------------------------------------------"
      end

      def prompt_user_to_select_article
        str = "\nEnter a number between 1-#{NewsTracker::Article.all.size} to view more detail\n"
        str += "Type 'back' to return to the main menu\n"
        str += "------------------------------------------------------------------\n"
      end

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


    end
  end
end

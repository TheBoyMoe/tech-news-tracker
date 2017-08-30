module NewsTracker
  module Menu
    class List

      @@urls = [
        "http://rubyweekly.com/rss/16581bfg",
        "http://javascriptweekly.com/rss/221bj275",
        "https://nodeweekly.com/rss/"
      ]

      def initialize(command)
        @command = command
        populate_article_cache
        puts "cache size #{NewsTracker::Article.all.size}"
      end

      def display
        # display the list of articles
        puts build_article_list
      end

      def read_menu_command
        @command = $stdin.gets.strip.downcase
      end

      private
      def build_article_list
        str = "------------------------------------------------------------------\n  Displaying #{@command} news:\n------------------------------------------------------------------\n"
        NewsTracker::Article.all.each.with_index(1) do |article, i|
          str += "  #{i}. #{article.title}\n"
        end
        str += "------------------------------------------------------------------"
      end

      def rss_feed_url
        num = -1
        case @command
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

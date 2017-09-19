require_relative "./common"

module NewsTracker
  module Menu
    class Article < Common
      attr_reader :article_number, :list_type

      def initialize(article_number, list_type)
        @article_number = article_number
        @list_type = list_type
      end

      def display
        puts "calling display"
        if @list_type != 'archive'
          <<~HEREDOC
            #{line_break}
            #{generate_article_content}
            #{line_break}
            #{prompt_user_to_open}
            #{prompt_user_to_archive}
            #{line_break}
            #{prompt_user_to_go_back}
            #{line_break}
          HEREDOC
        else
          <<~HEREDOC
            #{line_break}
            #{generate_article_content}
            #{line_break}
            #{prompt_user_to_open}
            #{line_break}
            #{prompt_user_to_go_back}
            #{line_break}
          HEREDOC
        end
      end

      def process_command
        if @command == 'o'
          puts "opening article in browser.... returning to list"
          open_in_browser
        elsif @command == 'a'
          NewsTracker::Article.find_or_insert(@article)
          puts "article saved..... returning to list"
        end
        menu_type
      end

      private
        def menu_type
          if @list_type != 'archive'
            NewsTracker::Menu::List.new(@list_type)
          else
            NewsTracker::Menu::Archive.new
          end
        end

        def generate_article_content
          if @list_type != 'archive'
            @article = NewsTracker::Article.all[@article_number]
          else
            @article = NewsTracker::Article.fetch_article_from_archive(@article_number)
          end
          build_article_str
        end

        def prompt_user_to_open
          "Type 'o' to view in a browser"
        end

        def prompt_user_to_go_back
          "Type 'back' to review the list again"
        end

        def prompt_user_to_archive
          "Type 'a' to archive the article and return to article list"
        end

        def build_article_str
          "Title: #{@article.title}\nAuthor: #{@article.author}\nDescription: #{@article.description}"
        end

        # def text_wrap(s, width = 60)
        #   s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1")
        # end

        def open_in_browser
          # on ubuntu
          system("gnome-open '#{@article.url}'")
          # on mac
          # system("open '#{article.url}'")
        end

    end
  end
end

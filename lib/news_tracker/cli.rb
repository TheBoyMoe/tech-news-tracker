require 'pry'

class NewsTracker::CLI
  attr_accessor :current_menu

  def initialize
    @current_menu = NewsTracker::Menu::Main.new
  end

  def call
    print line_break
    print greet_user
    display_menu
  end

  def display_menu
    print main_menu
    process_main_input
  end

  def process_main_input
    print article_list
    process_list_input
  end

  def process_list_input
    print article
    # process_article_input # FIXME

  end

  def process_article_input
    input = current_menu.read_menu_command
    if input == 'o'
      open_in_browser(@article)
    elsif input == 'a'
      NewsTracker::Article.find_or_insert(@article)
      puts "article saved..... returning to list"
    end
    print @list_string
    # TODO
  end

  def main_menu
    current_menu.display
  end

  def article_list
    # read user input from main menu, set @command
    current_menu.read_menu_command
    # switch the current menu based on user input
    @current_menu = current_menu.process_command
    if current_menu.instance_of?(NewsTracker::Menu::List) || current_menu.instance_of?(NewsTracker::Menu::Archive)
      @list_string = current_menu.display
    elsif current_menu.instance_of?(NewsTracker::Menu::Main)
      display_menu
    end
  end

  def article
    if current_menu.instance_of?(NewsTracker::Menu::List) || current_menu.instance_of?(NewsTracker::Menu::Archive)

      # capture & process user input from article list
      current_menu.read_menu_command
      result = current_menu.process_command
      if result.instance_of?(NewsTracker::Article)
        @article = result
        article_string
      else
        @current_menu = result
        if result.instance_of?(NewsTracker::Menu::Main)
          display_menu
        else
          puts 'unknown input, try again'
          @list_string
          # TODO handle user input on list menu
        end
      end
    end
  end



  private

    def article_string
      if current_menu.instance_of? NewsTracker::Menu::List
        <<~HEREDOC
          #{line_break}
          #{build_article}
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
          #{build_article}
          #{line_break}
          #{prompt_user_to_open}
          #{line_break}
          #{prompt_user_to_go_back}
          #{line_break}
        HEREDOC
      end
    end

    def build_article
      "Title: #{@article.title}\nAuthor: #{@article.author}\nDescription: #{text_wrap(@article.description)}" # FIXME
    end

    def greet_user
      "\n\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n\n"
    end

    def prompt_user_to_archive
      "Type 'a' to archive the article and return to article list"
    end

    def prompt_user_to_open
      "Type 'o' to view in a browser"
    end

    def prompt_user_to_go_back
      "Type 'back' to review the list again"
    end

    def line_break
      "------------------------------------------------------------------"
    end

    def clear_screen
      system "clear"
    end

    def text_wrap(s, width = 60)
      s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1")
    end


    def open_in_browser(article)
      # on ubuntu
      system("gnome-open '#{@article.url}'")
      # on mac
      # system("open '#{article.url}'")
    end

end

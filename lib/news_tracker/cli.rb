require 'pry'

class NewsTracker::CLI
  attr_reader :current_menu

  def initialize
    @current_menu = NewsTracker::Menu::Main.new
  end

  def call
    print line_break
    print greet_user
    print main_menu
    capture_main_menu_input
  end

  def main_menu
    # display options and wait for input
    #print @current_menu.display
    current_menu.display
  end

  def capture_main_menu_input
    # read user input, set @command
    current_menu.read_menu_command
    # switch the current menu based on user input
    @current_menu = current_menu.process_command
    display_list
  end

  def display_list
    # display sub_menu or return to main
    if current_menu.instance_of?(NewsTracker::Menu::List) || current_menu.instance_of?(NewsTracker::Menu::Archive)
      # display the article list
      print current_menu.display
      # capture user input
      current_menu.read_menu_command
      # validate user input
      result = current_menu.process_command
      if result.instance_of?(NewsTracker::Article)
        puts display_article(result)
        process_article_input(result)
      elsif result.instance_of?(NewsTracker::Menu::Main)
        @current_menu = result
        print main_menu
        capture_main_menu_input
      else
        display_list
      end
    elsif current_menu.instance_of?(NewsTracker::Menu::Main)
      menu
    end
  end

  def display_article(article)
    if current_menu.instance_of? NewsTracker::Menu::List
      <<~HEREDOC
        #{line_break}
        #{build_article(article)}
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
        #{build_article(article)}
        #{line_break}
        #{prompt_user_to_open}
        #{line_break}
        #{prompt_user_to_go_back}
        #{line_break}
      HEREDOC
    end
  end


  private
    def process_article_input(article)
      input = current_menu.read_menu_command
      if input == 'o'
        open_in_browser(article)
      elsif input == 'a'
        NewsTracker::Article.find_or_insert(article)
        puts "article saved..... returning to list"
      end
      display_list
    end

    def build_article(article)
      "Title: #{article.title}\nAuthor: #{article.author}\nDescription: #{text_wrap(article.description)}"
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
      system("gnome-open '#{article.url}'")
      # on mac
      # system("open '#{article.url}'")
    end

end

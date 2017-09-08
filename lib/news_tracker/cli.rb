require 'pry'

class NewsTracker::CLI

  attr_reader :current_menu

  def initialize
    @current_menu = NewsTracker::Menu::Main.new
  end

  def call
    greet_user
    menu
  end

  def menu
    # display options and wait for input
    @current_menu.display
    # read user input, set @command
    @current_menu.read_menu_command
    # switch the current menu based on user input
    @current_menu = @current_menu.process_command
    display_list
  end

  def display_list
    # display sub_menu or return to main
    if @current_menu.instance_of?(NewsTracker::Menu::List) || @current_menu.instance_of?(NewsTracker::Menu::Archive)
      # display the article list
      puts @current_menu.display
      # capture user input
      @current_menu.read_menu_command
      # validate user input
      result = @current_menu.process_command
      # binding.pry # DEBUG
      if result.instance_of?(NewsTracker::Article)
        puts display_article(result)
      elsif result.instance_of?(NewsTracker::Menu::Main)
        @current_menu = result
        menu
      else
        display_list
      end
    elsif @current_menu.instance_of?(NewsTracker::Menu::Main)
      menu
    end
  end

  def display_article(article)
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
  end

  def build_article(article)
    "\nTitle: #{article.title}\nAuthor: #{article.author}\nDescription: #{text_wrap(article.description)}"
  end

  private

    def greet_user
      puts "------------------------------------------------------------------\n\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n\n"
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
      s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
    end

    def open_in_browser(article)
      # on ubuntu
      system("gnome-open '#{article.url}'")
      # on mac
      # system("open '#{article.url}'")
    end

################################################################################

  def print_archive_list
    if NewsTracker::Article.fetch_archive.size > 0
      puts self.build_archive_list_string
      self.prompt_user_to_make_selection
      input = gets.strip.to_i
      if input > 0 && input <= NewsTracker::Article.fetch_archive.size
        @viewing_archive = true
        @article_num = input
        @article = NewsTracker::Article.fetch_article_from_archive(@article_num)
        self.clear_screen
        self.print_article(@article)
        self.prompt_user_to_take_action
      elsif input > NewsTracker::Article.fetch_archive.size
        puts "input not recognised"
        sleep 1
        self.clear_screen
        self.print_archive_list
      end
    else
      puts "------------------------------------------------------------------\nNo articles found\nType 'menu' to return to the options menu or 'exit' to quit\n------------------------------------------------------------------\n"
    end
  end

  def build_archive_list_string
    str = "------------------------------------------------------------------\n  Displaying archive list:\n------------------------------------------------------------------\n"
    # fetch all archived articles from the database & print a list of archived articles
    NewsTracker::Article.fetch_archive.each.with_index(1) do |article, i|
      str += "  #{i}. #{article.title}\n"
    end
    str += "------------------------------------------------------------------\n"
  end

  def prompt_user_to_make_selection
    count = NewsTracker::Article.fetch_archive.size
    puts build_prompt_user_string(count)
  end

  # def prompt_user_to_take_action
  #   puts "------------------------------------------------------------------\nType 'back' to review the list again\nType 'menu' to return to the options menu or 'exit' to quit\n------------------------------------------------------------------\n"
  # end

  # def prompt_user_to_archive_article
  #   puts "Type 'a' to archive the article and return to article list"
  # end



end

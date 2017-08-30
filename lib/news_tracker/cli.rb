require 'pry'

class NewsTracker::CLI

  @@urls = [
    "http://rubyweekly.com/rss/16581bfg",
    "http://javascriptweekly.com/rss/221bj275",
    "https://nodeweekly.com/rss/"
  ]

  attr_reader :current_menu

  def initialize
    @current_menu = ::NewsTracker::Menu::Main.new
  end

  def call
    greet_user
    menu
  end

  def menu
    binding.pry
    @current_menu.display # display options and wait for input
    @current_menu.read_menu_command # read user input, set @command
    @current_menu = @current_menu.process_command
    sub_menu
      # list_options
    # input = gets.strip.downcase
    # topic = -1
    # @article_num = 0
    # @article = nil
    # @viewing_archive = false
    # while input != 'exit'
    #   self.clear_screen
    #   if input == 'ruby'
    #     self.print_titles(0)
    #     topic = 0
    #   elsif input == 'js'
    #     self.print_titles(1)
    #     topic = 1
    #   elsif input == 'node'
    #     self.print_titles(2)
    #     topic = 2
    #   elsif input == 'menu'
    #     self.list_options
    #   elsif input == 'list'
    #     @viewing_archive = false
    #     self.print_titles(topic)
    #   elsif input == 'archive'
    #     @viewing_archive = true
    #     self.print_archive_list
    #   elsif input == 'back'
    #     if @viewing_archive
    #       self.print_archive_list
    #     else
    #       @viewing_archive = false
    #       self.print_titles(topic)
    #     end
    #   elsif input == 'a'
    #     # insert the article into the database
    #     if @article != nil
    #       NewsTracker::Article.find_or_insert(@article)
    #     end
    #     self.print_titles(topic) # return to article list
    #   elsif (input.to_i > 0 && input.to_i <= NewsTracker::Article.all.size)
    #     @viewing_archive = false
    #     @article_num = input.to_i
    #     @article = NewsTracker::Article.all[@article_num - 1]
    #     self.print_article(@article)
    #     self.prompt_user_to_archive_article
    #     self.prompt_user_to_take_action
    #   elsif @article_num > 0 && input == 'o'
    #     self.open_in_browser(@article)
    #     sleep 1
    #     if @viewing_archive
    #       self.prompt_user_to_take_action
    #     else
    #       self.prompt_user_to_archive_article
    #       self.prompt_user_to_take_action
    #     end
    #   else
    #     puts "Input not recognised, try again\nType 'menu' to return to the options menu or 'exit' to quit"
    #   end
    #   input = gets.strip
    # end
    # puts 'Goodbye!'
  end

  def sub_menu
    # display sub_menu or return to main
    if @current_menu.instance_of?(NewsTracker::Menu::List) || @current_menu.instance_of?(NewsTracker::Menu::Archive)
      @current_menu.display
    elsif @current_menu.instance_of?(NewsTracker::Menu::Main)
      @current_menu.call
    end
  end



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

  def print_titles(topic)
    puts self.build_title_string(topic)
    self.prompt_user_to_select_article
  end

  def greet_user
    puts "------------------------------------------------------------------\n\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n\n"
  end

  # def list_options
  #   puts "------------------------------------------------------------------\n  Option menu:\n------------------------------------------------------------------\n  Select a topic to list the latest articles\n  Type 'ruby' for Ruby and Rails news\n  Type 'js' for Javascript news\n  Type 'node' for NodeJS news\n  Type 'archive' to view article archive\n  Type 'exit' to quit\n------------------------------------------------------------------\n"
  # end

  def print_article(article)
    puts "------------------------------------------------------------------\n\nTitle: #{article.title}\nAuthor: #{article.author}\nDescription: #{self.text_wrap(article.description)}\n------------------------------------------------------------------\nType 'o' to view in a browser\n"
  end

  def build_title_string(topic)
    NewsTracker::Article.clear_all
    self.fetch_articles(topic)
    topic_str = topic_string(topic)
    str = "------------------------------------------------------------------\n  Displaying #{topic_str} news:\n------------------------------------------------------------------\n"
    NewsTracker::Article.all.each.with_index(1) do |article, i|
      str += "  #{i}. #{article.title}\n"
    end
    str += "------------------------------------------------------------------"
  end

  def fetch_articles(topic)
      NewsTracker::RssFeed.new(@@urls[topic]).create_article_instances_from_hashes
  end

  def prompt_user_to_select_article
    count = NewsTracker::Article.all.count
    puts build_prompt_user_string(count)
  end

  def build_prompt_user_string(count)
    "Enter a number between 1-#{count} to pick an article\nType 'menu' to return to the options menu or 'exit' to quit\n------------------------------------------------------------------\n"
  end

  def prompt_user_to_take_action
    puts "------------------------------------------------------------------\nType 'back' to review the list again\nType 'menu' to return to the options menu or 'exit' to quit\n------------------------------------------------------------------\n"
  end

  def prompt_user_to_archive_article
    puts "Type 'a' to archive the article and return to article list"
  end

  def topic_string(number)
    str = ''
    case number
    when 0
      str = 'Ruby'
    when 1
      str = 'Javascript'
    when 2
      str = 'NodeJS'
    end
    str
  end

  def clear_screen
    system "clear"
  end

  def text_wrap(s, width = 54)
    s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
  end

  def open_in_browser(article)
    # on ubuntu
    system("gnome-open '#{article.url}'")
    # on mac
    # system("open '#{article.url}'")
  end

end

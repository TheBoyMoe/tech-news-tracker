class NewsTracker::CLI

  @@urls = [
    "http://rubyweekly.com/rss/16581bfg",
    "http://javascriptweekly.com/rss/221bj275",
    "https://nodeweekly.com/rss/"
  ]

  def call
    self.greet_user
    self.menu
  end

  def menu
    self.list_options
    # capture & process user input
    input = gets.strip.downcase
    topic = -1
    article_num = 0
    while input != 'exit'
      self.clear_screen
      if input == 'ruby'
        self.print_titles(0)
        topic = 0
      elsif input == 'js'
        self.print_titles(1)
        topic = 1
      elsif input == 'node'
        self.print_titles(2)
        topic = 2
      elsif input == 'menu'
        self.list_options
      elsif input == 'list'
        self.print_titles(topic)
      elsif (input.to_i > 0 && input.to_i < NewsTracker::Article.all.size)
        article_num = input.to_i
        self.print_article(input.to_i)
        self.prompt_user_to_take_action
      elsif article_num > 0 && input == 'o'
        NewsTracker::Article.all[article_num - 1].open_in_browser
        sleep 1
        self.prompt_user_to_archive_article
        self.prompt_user_to_take_action
      else
        puts "Input not recognised, try again\nType 'menu' to return to the options menu or 'exit' to quit"
      end
      input = gets.strip
    end
    puts 'Goodbye!'
  end

  def print_titles(topic)
    puts self.build_title_string(topic)
    self.prompt_user_to_select_article
  end

  def greet_user
    puts "------------------------------------------------------------------\n\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n\n"
  end

  def list_options
    puts "------------------------------------------------------------------\n  Option menu:\n------------------------------------------------------------------\n  Select a topic to list the latest articles\n  Type 'ruby' for Ruby and Rails news\n  Type 'js' for Javascript news\n  Type 'node' for NodeJS news\n  Type 'archive' to view article archive\n  Type 'exit' to quit\n------------------------------------------------------------------\n"
  end

  def print_article(number)
    article = NewsTracker::Article.all[number - 1]
    puts "------------------------------------------------------------------\n\nTitle: #{article.title}\nAuthor: #{article.author}\nDescription: #{self.text_wrap(article.description)}\n------------------------------------------------------------------\nType 'o' to view in a browser\nType 'a' to archive the article"
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
    puts "Enter a number between 1-#{count} to pick an article\nType 'menu' to return to the options menu or 'exit' to quit"
  end

  def prompt_user_to_take_action
    puts "------------------------------------------------------------------\nType 'list' to review the list again\nType 'menu' to return to the options menu or 'exit' to quit\n------------------------------------------------------------------\n"
  end

  def prompt_user_to_archive_article
    puts "------------------------------------------------------------------\nType 'a' to archive the article"
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

end

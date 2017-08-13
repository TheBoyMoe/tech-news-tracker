class NewsTracker::CLI

  # def initialize
  #   # fetch the articles from ea on app launch
  # end

  @@urls = [
    "http://rubyweekly.com/rss/16581bfg",
    "http://javascriptweekly.com/rss/221bj275",
    "http://nodeweekly.com/rss/1el2m89n"
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
    while input != 'exit'
      if input == 'ruby'
        self.print_articles(0)
        topic = 0
      elsif input == 'js'
        self.print_articles(1)
        topic = 1
      elsif input == 'node'
        self.print_articles(2)
        topic = 2
      elsif input == 'menu'
        self.list_options
      elsif input == 'list'
        self.handle_input(topic)
      elsif (input.to_i > 0 && input.to_i < NewsTracker::Article.all.size)
        self.print_article(input.to_i)
        self.prompt_user_to_take_action
      else
        puts 'Input not recognised, try again'
      end
      input = gets.strip
    end
    puts 'Goodbye!'
  end

  def print_articles(topic)
    puts self.fetch_titles(topic)
    self.prompt_user_to_select_article
  end

  def greet_user
    puts "------------------------------------------------------------------\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n------------------------------------------------------------------"
  end

  def list_options
    puts "  Select a topic to list the latest articles\n  Type 'ruby' for Ruby and Rails news\n  Type 'js' for Javascript news\n  Type 'node' for NodeJS news\n  Type 'exit' to quit\n\n"
  end

  # TODO
  def print_article(number)
    puts "displaying details for article #{number}"
  end

  # TODO
  def fetch_titles(topic)
    NewsTracker::Article.clear_all
    topic_str = topic_string(topic)
    str = "Displaying #{topic_str} news:\n------------------------------------------------------------------\n"
    articles = NewsTracker::RssFeed.new(@@urls[topic]).create_article_instances_from_hashes
    articles.each.with_index(1) do |article, i|
      str += "  #{i}. #{article.title}\n"
    end
    str += "------------------------------------------------------------------"

    # puts "Displaying #{topic} news:\n------------------------------------------------------------------\n  1. Fixing bundler's dependency resolution algorithm\n  2. A crash course in analysing memory usage in Ruby\n  3. Redis 4.0 now on RedisGreen\n  4. Looking into CSFR protection in Rails\n  5. Advanced anumeration in Ruby\n  6. Why it's just lazy to bad mouth Rails\n  7. Effectively managing localization files in Rails\n------------------------------------------------------------------"
  end

  def prompt_user_to_select_article
    puts "  Enter a number between 1-7 to pick an article or\n  type 'menu' to return to the options menu or 'exit' to quit"
  end

  def prompt_user_to_take_action
    puts "Type 'list' to review the list again, 'menu' to return to the options or 'exit' to quit"
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

end

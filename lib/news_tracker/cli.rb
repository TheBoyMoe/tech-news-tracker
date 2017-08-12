class NewsTracker::CLI

  def initialize
    # TODO
    # load the articles on app launch
  end

  def call
    self.greet_user
    self.menu
  end

  def menu
    self.list_options
    # capture & process user input
    input = gets.strip.downcase
    topic = 0
    while input != 'exit'
      if input == 'ruby'
        self.handle_input(1)
        topic = 1
      elsif input == 'js'
        self.handle_input(2)
        topic = 2
      elsif input == 'node'
        self.handle_input(3)
        topic = 3
      elsif input == 'menu'
        self.list_options
      elsif input == 'list'
        self.handle_input(topic)
      elsif (input.to_i > 0 && input.to_i < 8)
        self.print_article(input.to_i)
        self.prompt_user_to_take_action
      else
        puts 'Input not recognised, try again'
      end
      input = gets.strip
    end
    puts 'Goodbye!'
  end

  def handle_input(topic)
    self.print_articles(topic)
    self.prompt_user_to_select_article
  end

  def greet_user
    puts "------------------------------------------------------------------\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n------------------------------------------------------------------"
  end

  def list_options
    puts "  Select a topic to list the latest articles\n  Type 'ruby' for Ruby and Rails news\n  Type 'js' for Javascript news\n  Type 'node' for NodeJS news\n  Type 'exit' to quit\n\n"
  end

  # TODO requires test
  def print_article(number)
    puts "displaying details for article #{number}"
  end

  def print_articles(topic)
    puts "Displaying #{topic} news:\n------------------------------------------------------------------\n  1. Fixing bundler's dependency resolution algorithm\n  2. A crash course in analysing memory usage in Ruby\n  3. Redis 4.0 now on RedisGreen\n  4. Looking into CSFR protection in Rails\n  5. Advanced anumeration in Ruby\n  6. Why it's just lazy to bad mouth Rails\n  7. Effectively managing localization files in Rails\n------------------------------------------------------------------"
  end

  def prompt_user_to_select_article
    puts "  Enter a number between 1-7 to pick an article or\n  type 'menu' to return to the options menu or 'exit' to quit"
  end

  def prompt_user_to_take_action
    puts "Type 'list' to review the list again, 'menu' to return to the options or 'exit' to quit"
  end

end

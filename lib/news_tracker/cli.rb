class NewsTracker::CLI

  def initialize

  end

  def greet_user
    puts "------------------------------------------------------------------\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n------------------------------------------------------------------"
  end

  def list_options
    puts "  Select an option\n  '1' for Ruby and Rails news\n  '2' for Javascript news\n  '3' for NodeJS news\n  Type 'exit' to quit\n\n"
  end

  def call
    # TODO
    self.greet_user
    self.menu
  end

  def menu
    # TODO
    self.list_options
    # capture & process user input
    self.print_list
    self.prompt_user
  end

  def print_list
    puts "------------------------------------------------------------------\n  1. Fixing bundler's dependency resolution algorithm\n  2. A crash course in analysing memory usage in Ruby\n  3. Redis 4.0 now on RedisGreen\n  4. Looking into CSFR protection in Rails\n  5. Advanced anumeration in Ruby\n  6. Why it's just lazy to bad mouth Rails\n  7. Effectively managing localization files in Rails\n------------------------------------------------------------------"
  end

  def prompt_user
    puts "  Pick an article or type 'menu' to return to the options menu"
  end

end

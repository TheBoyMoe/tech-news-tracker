require 'pry'

class NewsTracker::CLI
  attr_reader :current_menu

  def initialize
    @current_menu = NewsTracker::Menu::Main.new
  end

  def call
    print line_break
    print greet_user
    menu
  end

  def menu
    print @current_menu.display
    @current_menu.read_menu_command
    # puts "CLI-pre #{@current_menu}" # DEBUG
    @current_menu = @current_menu.process_command
    # puts "CLI-post #{@current_menu}" # DEBUG
  end


  private
    def line_break
      "------------------------------------------------------------------"
    end

    def clear_screen
      system "clear"
    end

    def greet_user
      "\n\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n\n"
    end


end

require "spec_helper"
require 'stringio'

RSpec.describe NewsTracker::CLI do

  describe '#menu' do

    it 'prints the main menu' do
      expect(subject.current_menu).to be_a(NewsTracker::Menu::Main)
      expect{subject.current_menu.display}.to output("------------------------------------------------------------------\n  Option menu:\n------------------------------------------------------------------\n  Select a topic to list the latest articles\n  Type 'ruby' for Ruby and Rails news\n  Type 'js' for Javascript news\n  Type 'node' for NodeJS news\n  Type 'archive' to view article archive\n  Type 'exit' to quit\n------------------------------------------------------------------\n").to_stdout
    end

    context 'when I give a language command (js, ruby, node)' do
      before do
        $stdin = StringIO.new("ruby\n")
      end

      after do
        $stdin = STDIN
      end

      it 'should change the current menu to be the article list' do
        current_menu = subject.current_menu
        current_menu.read_menu_command
        current_menu = current_menu.process_command

        expect(current_menu).to be_a(NewsTracker::Menu::List)
      end

    end

    context "when I give the 'archive' command" do
      before do
        $stdin = StringIO.new("archive\n")
      end

      after do
        $stdin = STDIN
      end

      it "should change the current menu to the archive list" do
        current_menu = subject.current_menu
        current_menu.read_menu_command
        current_menu = current_menu.process_command

        expect(current_menu).to be_a(NewsTracker::Menu::Archive)
      end

    end

  end

  describe '#display_article_list' do

    context 'when the current menu changes to the list/archive' do
      # before do
      #   $stdin = StringIO.new("1")
      # end

      after do
        $stdin = STDIN
      end

      it 'switch the current menu to be NewsTracker::Menu::List' do
        $stdin = StringIO.new("ruby")

        suppress_output{ subject.menu }

        expect(subject.current_menu).to be_a(NewsTracker::Menu::List)
      end

      it 'should display the ruby article lists' do
        # expect(subject.current_menu).to receive(:display).and_call_original  ???

        # expect(subject.current_menu).to receive(:display)
        # expect(subject.current_menu).to receive(:read_menu_command)
        # expect(subject.current_menu).to receive(:process_command)
        #
        # suppress_output{subject.display_article_list}
        $stdin = StringIO.new("ruby\n")

        # test for a string
        str = "Displaying ruby news:"
        suppress_output{subject.menu}
        expect(subject.current_menu.display).to be_a(String)
        expect(subject.current_menu.display).to include(str)
      end

      # it 'can pick an article from the list' do
      #   $stdin = StringIO.new('1')
      #   suppress_output{subject.menu}
      #   input = suppress_output{subject.display_article_list}
      #
      #   expect(input).to eq('1')
      # end

      # it "or go back to the main options menu" do
      #
      # end

    end

  end

  describe 'display the selected article' do

    it "ensure the article number is valid" do
      count = NewsTracker::Article.all.size
      suppress_output{expect(subject.current_menu.process_command).to be_between(1, count)}
    end

    it "given the article number, retrive the article from cache" do
      expect(subject.current_menu.fetch_article).to be_a(NewsTracker::Article)
    end

    it "display the given article" do
      article = NewsTracker::Article.all.first
      expect(subject.current_menu.print_article).to output("------------------------------------------------------------------\n\nTitle: #{article.title}\nAuthor: #{article.author}\nDescription: #{subject.text_wrap(article.description)}\n------------------------------------------------------------------\nType 'o' to view in a browser\n").to_stdout
    end
  end

  # let(:titles){[
  #   "1. Fixing bundler's dependency resolution algorithm",
  #   "2. A crash course in analysing memory usage in Ruby",
  #   "3. Redis 4.0 now on RedisGreen",
  #   "4. Looking into CSFR protection in Rails",
  #   "5. Advanced anumeration in Ruby",
  #   "6. Why it's just lazy to bad mouth Rails",
  #   "7. Effectively managing localization files in Rails"
  # ]}
  #
  # describe '#greet_user' do
  #   it "Greet the user when the app launches" do
  #     expect{subject.greet_user}.to output("------------------------------------------------------------------\n\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n\n").to_stdout
  #   end
  # end
  #
  # describe '#list_options' do
  #   it "List the available options" do
  #     expect{subject.list_options}.to output("------------------------------------------------------------------\n  Option menu:\n------------------------------------------------------------------\n  Select a topic to list the latest articles\n  Type 'ruby' for Ruby and Rails news\n  Type 'js' for Javascript news\n  Type 'node' for NodeJS news\n  Type 'archive' to view article archive\n  Type 'exit' to quit\n------------------------------------------------------------------\n").to_stdout
  #   end
  # end
  #
  # describe '#build_title_string' do
  #   it "should return a string that includes 'Displaying Ruby news:'" do
  #     str = 'Displaying Ruby news:'
  #     expect(subject.build_title_string(0)).to be_a(String)
  #     expect(subject.build_title_string(0)).to include(str)
  #   end
  # end
  #
  # describe '#prompt_user_to_select_article' do
  #   it "prompt user to pick an article or return to the previous menu" do
  #     count = NewsTracker::Article.all.count
  #     expect{subject.prompt_user_to_select_article}.to output("Enter a number between 1-#{count} to pick an article\nType 'menu' to return to the options menu or 'exit' to quit\n------------------------------------------------------------------\n").to_stdout
  #   end
  # end
  #
  # describe '#print_article' do
  #   it "print the selected article to the screen" do
  #     article = NewsTracker::Article.all.first
  #     expect{subject.print_article(article)}.to output("------------------------------------------------------------------\n\nTitle: #{article.title}\nAuthor: #{article.author}\nDescription: #{subject.text_wrap(article.description)}\n------------------------------------------------------------------\nType 'o' to view in a browser\n").to_stdout
  #   end
  # end
  #
  # describe '#prompt_user_to_take_action' do
  #   it "prompt user to take action following the display of article details" do
  #     expect{subject.prompt_user_to_take_action}.to output("------------------------------------------------------------------\nType 'back' to review the list again\nType 'menu' to return to the options menu or 'exit' to quit\n------------------------------------------------------------------\n").to_stdout
  #   end
  # end
  #
  # describe '#prompt_user_to_archive_article' do
    # it "promt the user to archive the recently opened article" do
    #   expect{subject.prompt_user_to_archive_article}.to output("Type 'a' to archive the article and return to article list\n").to_stdout
    # end
  # end


end

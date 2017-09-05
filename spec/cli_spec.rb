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

    context "when a user enters 'ruby'" do
      before do
        $stdin = StringIO.new("ruby\n")
      end

      after do
        $stdin = STDIN
      end

      it 'should display a list of articles related to ruby news' do
        # check for a string
        # check it includes 'Displaying ruby news:'
      end

    end

  end

  describe '#display_article' do

    context 'should display the selected article' do
      it 'an article should contain a title, author and description field' do
        # check  that it is a string
        # check that it includes 'title'
        # check that it includes 'author'
        # check that it includes 'content'
      end
    end

  end

end

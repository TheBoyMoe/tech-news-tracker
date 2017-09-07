require "spec_helper"
require 'stringio'

RSpec.describe NewsTracker::CLI do

  describe '#menu' do

    it 'prints the main menu' do
      expect(subject.current_menu).to be_a(NewsTracker::Menu::Main)
      expect{subject.current_menu.display}.to output("------------------------------------------------------------------\n  Option menu:\n------------------------------------------------------------------\n  Select a topic to list the latest articles\n  Type 'ruby' for Ruby and Rails news\n  Type 'js' for Javascript news\n  Type 'node' for NodeJS news\n  Type 'archive' to view article archive\n  Type 'exit' to quit\n------------------------------------------------------------------\n").to_stdout
    end

    # context 'when I give a language command (js, ruby, node)' do
    #   before do
    #     $stdin = StringIO.new("ruby\n")
    #   end
    #
    #   after do
    #     $stdin = STDIN
    #   end
    #
    #   it 'should change the current menu to be the article list' do
    #     current_menu = subject.current_menu
    #     current_menu.read_menu_command
    #     current_menu = current_menu.process_command
    #
    #     expect(current_menu).to be_a(NewsTracker::Menu::List)
    #   end
    #
    # end

    # context "when I give the 'archive' command" do
    #   before do
    #     $stdin = StringIO.new("archive\n")
    #   end
    #
    #   after do
    #     $stdin = STDIN
    #   end
    #
    #   it "should change the current menu to the archive list" do
    #     current_menu = subject.current_menu
    #     current_menu.read_menu_command
    #     current_menu = current_menu.process_command
    #
    #     expect(current_menu).to be_a(NewsTracker::Menu::Archive)
    #   end
    #
    # end

  end

  describe '#display_list' do

    context "when a user enters 'ruby'" do
      before do
        $stdin = StringIO.new("ruby\n")
      end

      after do
        $stdin = STDIN
      end

      it 'should display a list of articles related to ruby news' do
        subject.current_menu.read_menu_command
        current_menu = subject.current_menu.process_command
        str = current_menu.display

        expect(str).to be_a(String)
        expect(str).to include('Displaying ruby news:')
      end

    end

  end

  describe '#display_article' do

    context 'should display the selected article' do
      before do
        $stdin = StringIO.new("1\n")
      end

      after do
        $stdin = STDIN
      end

      it 'an article should contain a title, author and description field' do


        # str = subject.display_article

        # expect(str).to include('Title')
        # expect(str).to include('Author')
        # expect(str).to include('Description')
      end
    end

  end

end

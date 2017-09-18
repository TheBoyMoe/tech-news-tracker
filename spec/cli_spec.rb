require "spec_helper"
require 'stringio'

RSpec.describe NewsTracker::CLI do

  describe '#initialize' do

    it 'initialize CLI with the NewsTracker::Menu::Main' do
      expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Main)
    end

  end

  describe '#menu' do

    context "when a user enters 'ruby'" do
      before do
        $stdin = StringIO.new("ruby\n")
      end

      after do
        $stdin = STDIN
      end

      it 'should change the current menu to NewsTracker::Menu::List' do
        suppress_output { subject.menu }

        expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::List)
      end
    end

    context "when a user enters 'ruby' and selects the first article" do
      before do
        $stdin = StringIO.new("ruby\n1\n")
      end

      after do
        $stdin = STDIN
      end

      it 'should switch to an article menu' do
        suppress_output {
          subject.menu
          subject.menu
        }

        expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Article)
      end
    end

    context "when a user enters 'archive'" do
      before do
        $stdin = StringIO.new("archive\n")
      end
      after do
        $stdin = STDIN
      end

      it "should change the current menu to NewsTracker::Menu::Archive" do
        suppress_output{subject.menu}

        expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Archive)
      end
    end

    context "when a user enters 'archive' and selects the first article" do


      before do
        NewsTracker::Article.create_table
        article = NewsTracker::Article.new
        article.insert

        $stdin = StringIO.new("archive\n1\n")
      end

      after do
        NewsTracker::Article.drop_table

        $stdin = STDIN
      end

      it 'should switch to an article menu' do
        suppress_output {
          subject.menu
          subject.menu
        }

        expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Article)
      end
    end

    context 'if select ruby and select back' do
      before do
        $stdin = StringIO.new("ruby\nback\n")
      end

      after do
        $stdin = STDIN
      end
      it "then goes back to main menu" do
        suppress_output {
          subject.menu
          subject.menu
        }

        expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Main)
      end
    end

  end

  # describe '#display_list' do
  #
  # end


  # describe '#display_article' do
  #
  #   context 'should display the selected article' do
  #     before do
  #       $stdin = StringIO.new("1")
  #     end
  #
  #     after do
  #       $stdin = STDIN
  #     end
  #
  #     it 'an article should contain a title, author and description field and prompt the user to take action' do
  #       current_menu = NewsTracker::Menu::List.new('ruby')
  #       current_menu.read_menu_command
  #       article = current_menu.process_command
  #       article_string = subject.display_article(article)
  #
  #       # when using multiple expectations for a test check
  #       # https://relishapp.com/rspec/rspec-core/docs/expectation-framework-integration/aggregating-failures
  #       expect(article_string).to include('Title:')
  #       expect(article_string).to include('Author:')
  #       expect(article_string).to include('Description:')
  #       # expect(article_string).to include("Type 'a' to archive the article and return to article list")
  #       expect(article_string).to include("Type 'o' to view in a browser")
  #       expect(article_string).to include("Type 'back' to review the list again")
  #     end
  #
  #   end
  #
  # end

end

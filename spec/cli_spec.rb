require "spec_helper"
require 'stringio'

RSpec.describe NewsTracker::CLI do

  describe '#initialize' do

    it 'initialize CLI with the NewsTracker::Menu::Main' do
      expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Main)
    end

  end

  describe '#menu' do

    context "main menu" do

      context "when a user enters 'ruby'" do
        before do
          $stdin = StringIO.new("ruby\n")
        end

        after do
          $stdin = STDIN
        end

        it 'should switch menu to NewsTracker::Menu::List' do
          suppress_output { subject.menu }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::List)
        end
      end

      context "when a user enters 'archive'" do
        before do
          $stdin = StringIO.new("archive\n")
        end
        after do
          $stdin = STDIN
        end

        it "should switch menu to NewsTracker::Menu::Archive" do
          suppress_output{subject.menu}

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Archive)
        end
      end

      # context "when a user enters 'exit'" do
      #   before do
      #     $stdin = StringIO.new("exit\n")
      #   end
      #   after do
      #     $stdin = STDIN
      #   end
      #
      #   it "should terminate the app" do
      #     suppress_output{subject.menu}
      #     expect(subject.current_menu).to eq(nil)
      #   end
      # end

      context "when a user enters 'unknown'" do
        before do
          $stdin = StringIO.new("unknown\n")
        end
        after do
          $stdin = STDIN
        end

        it "should remain on the same menu, NewsTracker::Menu::Main" do
          suppress_output{subject.menu}

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Main)
        end
      end

    end


    context "list menu" do

      context "when a user enters 'ruby' and selects the first article" do
        before do
          $stdin = StringIO.new("ruby\n1\n")
        end

        after do
          $stdin = STDIN
        end

        it 'should switch menu to NewsTracker::Menu::Article' do
          suppress_output {
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Article)
        end
      end

      context "when a user enters 'ruby' and enters back" do
        before do
          $stdin = StringIO.new("ruby\nback\n")
        end

        after do
          $stdin = STDIN
        end

        it "should switch menu to NewsTracker::Menu::Main" do
          suppress_output {
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Main)
        end
      end

      context "when a user enters 'ruby' and enters 'unknown'" do
        before do
          $stdin = StringIO.new("ruby\nunknown\n")
        end

        after do
          $stdin = STDIN
        end

        it "should remain on the same menu, NewsTracker::Menu::List" do
          suppress_output {
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::List)
        end
      end

    end


    context "archive menu" do

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

        it 'should switch menu to NewsTracker::Menu::Article' do
          suppress_output {
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Article)
        end
      end

      context "when a user enters 'archive' and enters 'back'" do
        before do
          NewsTracker::Article.create_table

          $stdin = StringIO.new("archive\nback\n")
        end

        after do
          NewsTracker::Article.drop_table

          $stdin = STDIN
        end

        it "should switch menu to NewsTracker::Menu::Main" do
          suppress_output {
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Main)
        end
      end

      context "when a user enters 'archive' and enters 'unknown'" do
        before do
          NewsTracker::Article.create_table

          $stdin = StringIO.new("archive\nunknown\n")
        end

        after do
          NewsTracker::Article.drop_table

          $stdin = STDIN
        end

        it "should remain on the same menu, NewsTracker::Menu::Archive" do
          suppress_output {
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Archive)
        end
      end

    end


    context "article menu" do

      # TODO opens arcticle browser
      context "when a user enters 'ruby', selects the first article and enters 'o'" do
        before do
          $stdin = StringIO.new("ruby\n1\no\n")
        end

        after do
          $stdin = STDIN
        end

        it "should open the article in a browser window" do

        end

        it "should switch menu to NewsTracker::Menu::List" do
          suppress_output {
            subject.menu
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::List)
        end
      end

      # TODO check data base count went up
      context "when a user enters 'ruby', selects the first article and enters 'a'" do
        before do
          NewsTracker::Article.create_table

          $stdin = StringIO.new("ruby\n1\na\n")
        end

        after do
          NewsTracker::Article.drop_table

          $stdin = STDIN
        end

        it "the number of articles saved to the database should go up by 1" do

        end

        it "should go back to NewsTracker::Menu::List" do
          suppress_output {
            subject.menu
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::List)
        end

      end

      context "when a user enters 'ruby', selects the first article and enters 'back'" do
        before do
          $stdin = StringIO.new("ruby\n1\nback\n")
        end

        after do
          $stdin = STDIN
        end

        it "should go back to NewsTracker::Menu::List" do
          suppress_output {
            subject.menu
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::List)
        end
      end

      context "when a user enters 'ruby', selects the first article and enters 'unknown'" do
        before do
          $stdin = StringIO.new("ruby\n1\nunknown\n")
        end

        after do
          $stdin = STDIN
        end

        it "should go back to NewsTracker::Menu::List" do
          suppress_output {
            subject.menu
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::List)
        end
      end

      # TODO opens article in browser
      context "when a user enters 'archive', selects the first article and enters 'o'" do
        before do
          NewsTracker::Article.create_table
          article = NewsTracker::Article.new
          article.insert

          $stdin = StringIO.new("archive\n1\no\n")
        end

        after do
          NewsTracker::Article.drop_table

          $stdin = STDIN
        end

        it "should open the article in a browser window" do

        end

        it "should go back to NewsTracker::Menu::Archive" do
          suppress_output {
            subject.menu
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Archive)
        end

      end

      context "when a user enters 'archive', selects the first article and enters 'back'" do
        before do
          NewsTracker::Article.create_table
          article = NewsTracker::Article.new
          article.insert

          $stdin = StringIO.new("archive\n1\nback\n")
        end

        after do
          NewsTracker::Article.drop_table

          $stdin = STDIN
        end

        it "should go back to NewsTracker::Menu::Archive" do
          suppress_output {
            subject.menu
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Archive)
        end
      end

      context "when a user enters 'archive', selects the first article and enters 'unknown'" do
        before do
          NewsTracker::Article.create_table
          article = NewsTracker::Article.new
          article.insert

          $stdin = StringIO.new("archive\n1\nunknown\n")
        end

        after do
          NewsTracker::Article.drop_table

          $stdin = STDIN
        end

        it "should go back to NewsTracker::Menu::Archive" do
          suppress_output {
            subject.menu
            subject.menu
            subject.menu
          }

          expect(subject.current_menu).to be_a_instance_of(NewsTracker::Menu::Archive)
        end
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

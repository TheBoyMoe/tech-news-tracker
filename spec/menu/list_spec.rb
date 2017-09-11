require "spec_helper"
require 'stringio'

RSpec.describe NewsTracker::Menu::List do

  # seems like this should be wrapped in
  #
  # describe '#display' do
  # end
  #
  context "when the 'ruby' article list is selected" do
    #
    # Something fishy is going on here. To be discussed.
    #
    # fetch the articles & populate the article cache
    NewsTracker::Menu::List.new('ruby')

    # this seems to be testing NewsTracker::Article instead of
    # NewsTracker::Menu::List
    it "retrieve an array of article instances" do
      articles = NewsTracker::Article.all

      expect(articles).to be_a(Array)
      expect(articles.first).to be_a_instance_of(NewsTracker::Article)
    end

    it 'build a string of the article list for display' do
      subject = NewsTracker::Menu::List.new('ruby')
      expect(subject.display).to include('Displaying ruby news:')
    end

  end

  # seems like this should be wrapped in
  #
  # describe '#process_command' do
  # end
  #
  describe 'prompt the user to select an article, or go back to the previous menu' do
    # subject { NewsTracker::Menu::List.new('ruby') }
    subject = NewsTracker::Menu::List.new('ruby')

    context "if the user enters a valid number" do
      before do
        $stdin = StringIO.new("1\n")
      end

      after do
        $stdin = STDIN
      end

      it "an article instance is returned" do
        subject.read_menu_command
        article = subject.process_command

        expect(article).to be_a_instance_of(NewsTracker::Article)
      end
    end

    context "if the user enters 'back'" do
      before do
        $stdin = StringIO.new("back\n")
      end

      after do
        $stdin = STDIN
      end

      it "an instance of NewsTracker::Menu::Main is returned" do
        subject.read_menu_command
        result = subject.process_command

        expect(result).to be_a_instance_of(NewsTracker::Menu::Main)
      end
    end

    context "if the entry is 'unknown'" do
      before do
        $stdin = StringIO.new("'unknown'\n")
      end

      after do
        $stdin = STDIN
      end

      it "stay on the same menu" do
        subject.read_menu_command
        result = subject.process_command

        expect(result).to be_a_instance_of(NewsTracker::Menu::List)
      end
    end

  end

end

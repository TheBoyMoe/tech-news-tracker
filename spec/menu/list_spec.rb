require "spec_helper"
require 'stringio'

RSpec.describe NewsTracker::Menu::List do

  context "when the 'ruby' article list is selected" do
    NewsTracker::Menu::List.new('ruby')

    it "retrieve an array of 'ruby' article instances" do
      articles = NewsTracker::Article.all

      expect(articles).to be_a(Array)
      expect(articles.first).to be_a_instance_of(NewsTracker::Article)
    end

    it 'build a string of the article list for display' do
      subject = NewsTracker::Menu::List.new('ruby')
      expect(subject.build_article_list).to include('Displaying ruby news:')
    end

  end

  context 'prompt the user to select an article, or go back to the previous menu' do

    it "if the user enters a number, check that it's within the valid range" do

    end

    it "if the user enters 'back', return to the previous menu" do

    end

    it "if the entry is 'unknown', stay on the same menu" do

    end

  end

end

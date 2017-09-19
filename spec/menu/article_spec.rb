require "spec_helper"

RSpec.describe NewsTracker::Menu::Article do

  let(:article_menu){NewsTracker::Menu::Article.new(1, 'archive')}

  before do
    NewsTracker::Article.create_table
    article = NewsTracker::Article.new
    article.insert
  end

  after do
    NewsTracker::Article.drop_table
  end

  describe '#initialize' do
    context "when a user enters 'archive' and selects the first article" do
      it "sets the list type to 'archive' and article number to '1'" do
        expect(article_menu.list_type).to eq('archive')
        expect(article_menu.article_number).to eq(1)
      end
    end
  end

  describe '#display' do
    context "when a user enters 'archive' and selects the first article" do

      it "return a string that contains 'Title:', 'Author:', and 'Description:'" do
        article_string = article_menu.display

        expect(article_string).to be_a(String)
        expect(article_string).to include('Title:')
        expect(article_string).to include('Author:')
        expect(article_string).to include('Description:')
      end
    end
  end

end

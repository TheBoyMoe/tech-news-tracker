require "spec_helper"
# require 'stringio'

RSpec.describe NewsTracker::Menu::Archive do

  before(:each) do
    DB[:conn].execute('DROP TABLE IF EXISTS articles')
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS articles (
      id INTEGER PRIMARY KEY,
      title TEXT,
      author TEXT,
      description TEXT,
      url TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end

  after(:each) do
     DB[:conn].execute('DROP TABLE IF EXISTS articles')
  end

  let(:article) do
    NewsTracker::Article.new.tap do |article|
      article.title = 'ES6, The future of JS'
      article.author = 'John Smith'
    end
  end

  describe '#display' do

    context "when user selects 'archive'" do

      it "returns a string of the article list" do
        NewsTracker::Article.find_or_insert(article)
        str = subject.display

        expect(str).to be_a(String)
        expect(str).to include('Displaying list of archived articles')
        expect(str).to include('ES6, The future of JS')
      end

    end

  end


end

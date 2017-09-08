require "spec_helper"
require 'stringio'

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

  context "when user selects 'archive'" do
    article = NewsTracker::Article.new
    article.title = 'ES6, The future of JS'
    article.author = 'John Smith'

    it "retrives an array of article instances" do
      NewsTracker::Article.find_or_insert(article)
      articles = subject.fetch_articles

      expect(articles).to be_a(Array)
      expect(articles.first).to be_a_instance_of(NewsTracker::Article)
    end

    it "builds a string list of articles" do
      NewsTracker::Article.find_or_insert(article)
      str = subject.display

      expect(str).to be_a(String)
      expect(str).to include('Displaying list of archived articles')
      expect(str).to include('ES6, The future of JS')
    end
  end

end

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

  describe 'prompt the user to select an article, or go back to the previous menu' do
    article = NewsTracker::Article.new
    article.title = 'ES6, The future of JS'
    article.author = 'John Smith'

    context 'if the user enters a valid number' do
      before do
        $stdin = StringIO.new("1\n")
      end

      after do
        $stdin = STDIN
      end

      it " article instance is returned" do
        NewsTracker::Article.find_or_insert(article)
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

      it "return an instance of NewsTracker::Menu::Main" do
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

        expect(result).to be_a_instance_of(NewsTracker::Menu::Archive)
      end
    end
  end
end

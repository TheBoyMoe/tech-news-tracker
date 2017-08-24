require 'spec_helper'

RSpec.describe NewsTracker::Article do
  let(:article){NewsTracker::Article.new}

  describe 'article properties'    do
    it "has a title" do
      article.title = 'A crash course in analysing memory usage in ruby'
      expect(article.title).to eq('A crash course in analysing memory usage in ruby')
    end

    it 'has an author' do
      article.author = 'Thoughtbot'
      expect(article.author).to eq('Thoughtbot')
    end

    it "has a description" do
      article.description = 'How to use simple tools to measure the allocated and long-term memory usage of your apps.'
      expect(article.description).to eq('How to use simple tools to measure the allocated and long-term memory usage of your apps.')
    end

    it "has a url" do
      article.url = 'https://robots.thoughtbot.com/a-crash-course-in-analyzing-memory-usage-in-ruby'
      expect(article.url).to eq('https://robots.thoughtbot.com/a-crash-course-in-analyzing-memory-usage-in-ruby')
    end
  end

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

  describe '#save' do
    it "saves the particlular article to all articles" do
      article.save
      expect(NewsTracker::Article.all).to include(article)
    end
  end

  describe '.all' do
    it "should return all article instances" do
      article.save
      expect(NewsTracker::Article.all).to include(article)
    end
  end

  describe '.clear_all' do
    it "should clear all the article instances from @@all" do
      NewsTracker::Article.clear_all
      expect(NewsTracker::Article.all).to eq([])
    end
  end

  describe '.create_table' do
    it "creates the articles table in the database" do
      NewsTracker::Article.create_table
      sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='articles';"
      expect(DB[:conn].execute(sql)[0]).to eq(['articles'])
    end
  end

  describe '.drop_table' do
    it "drops the articles table from the database" do
      NewsTracker::Article.drop_table
      sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='articles';"
      expect(DB[:conn].execute(sql)[0]).to eq(nil)
    end
  end

  describe '#insert' do
    it "inserts an article instance to the database, returns an instance and sets the id attribute" do
      article.title = 'ES6, The future of JS'
      article.author = 'John Smith'
      article.description = 'The future of JS is here... '
      article.url = 'http://jsweekly.com'
      item = article.insert
      expect(item).to be_instance_of(NewsTracker::Article)
      expect(item.id).not_to eq(nil)
    end
  end

  describe '.find_or_insert' do
    it "creates an instance of article and inserts it into the database if it does not already exist" do
      article.title = 'ES6, The future of JS'
      article.author = 'John Smith'
      article.description = 'The future of JS is here... '
      article.url = 'http://jsweekly.com'
      item1 = article.insert

      item2 = NewsTracker::Article.find_or_insert(article)

      expect(item1).to be_instance_of(NewsTracker::Article)
      expect(item2).to be_instance_of(NewsTracker::Article)
      expect(item1.id).to eq(item2.id)
    end

    it "when two articles have the same author, but different titles, both should be inserted" do
      item1 = NewsTracker::Article.new
      item1.title = 'ES6, The future of JS'
      item1.author = 'John Smith'
      item1.description = nil
      item1.url = nil

      item2 = NewsTracker::Article.new
      item2.title = 'Build a Chatbot with NodeJS'
      item2.author = 'John Smith'
      item2.description = nil
      item2.url = nil

      item1 = NewsTracker::Article.find_or_insert(item1)
      item2 = NewsTracker::Article.find_or_insert(item2)

      expect(item1.id).not_to eq(item2.id)
    end
  end

  describe '.new_from_db' do
    it "creates an instance of Article from attribute values" do
      row = [1, 'ES6, The future of JS', 'John Smith', 'The future of JS is here... ', 'http://jsweekly.com']
      article = NewsTracker::Article.new_from_db(row)
      expect(article).to be_instance_of(NewsTracker::Article)
      expect(article.id).to eq(row[0])
      expect(article.title).to eq(row[1])
      expect(article.author).to eq(row[2])
      expect(article.description).to eq(row[3])
      expect(article.url).to eq(row[4])
    end
  end

end

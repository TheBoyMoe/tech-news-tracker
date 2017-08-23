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

end

require 'spec_helper'

RSpec.describe NewsTracker::RssFeed do

  # TODO update with vcr gem
  describe '#create_article_instances_from_hashes' do

    it "should create article instances from hashes, save those instances to NewsTracker::Article.all" do
      NewsTracker::Article.clear_all
      url = 'http://rubyweekly.com/rss/1b38al0g'
      NewsTracker::RssFeed.new(url).create_article_instances_from_hashes
      articles = NewsTracker::Article.all
      expect(articles).to be_a(Array)
      expect(articles.first).to be_an_instance_of(NewsTracker::Article)
      expect(articles.first.title).to eq("The Limits of Copy-on-Write: How Ruby Allocates Memory")
      expect(articles.first.author).to eq("Brandur Leach")
      expect(articles.first.description).to eq("How heap and object allocation work in Ruby, often leading to bloated sub-processes, and what’s on the roadmap to help.")
      expect(articles.first.url).to eq("https://brandur.org/ruby-memory")
    end
  end

end

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
      expect(articles.first.title).to eq("An Introduction to Concurrency Models in Ruby")
      expect(articles.first.author).to eq("Universe Engineering")
      expect(articles.first.description).to eq("In this first of a series, we see the differences between and pros and cons of fibers, EventMachine, threads and processes.")
      expect(articles.first.url).to eq("https://engineering.universe.com/introduction-to-concurrency-models-with-ruby-part-i-550d0dbb970")
    end
  end

end

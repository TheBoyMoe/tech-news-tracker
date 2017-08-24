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
      expect(articles.first.title).to eq("TestProf: A Doctor for Slow Ruby Tests")
      expect(articles.first.author).to eq("Martian Chronicles")
      expect(articles.first.description).to eq("TestProf is a test profiling toolbox containing tools for profiling by test type or database event as well as faking background jobs.")
      expect(articles.first.url).to eq("https://evilmartians.com/chronicles/testprof-a-good-doctor-for-slow-ruby-tests")
    end
  end

end

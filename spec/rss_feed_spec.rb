require 'spec_helper'

RSpec.describe NewsTracker::RssFeed do

  # TODO update with vcr gem
  describe '#create_article_instances_from_hashes' do
    it "returns an array of article instances" do
      # url = './fixtures/rss_feed/ruby_weekly_newsletter.xml'
      url = 'http://rubyweekly.com/rss/1b38al0g'
      articles = NewsTracker::RssFeed.new(url).create_article_instances_from_hashes
      expect(articles).to be_a(Array)
      expect(articles.first).to be_an_instance_of(NewsTracker::Article)
    end

    it "should save article instances to NewsTracker::Article.all" do
      NewsTracker::Article.clear_all
      url = 'http://rubyweekly.com/rss/1b38al0g'
      NewsTracker::RssFeed.new(url).create_article_instances_from_hashes
      articles = NewsTracker::Article.all
      expect(articles).to be_a(Array)
      expect(articles.first).to be_an_instance_of(NewsTracker::Article)
      expect(articles.first.title).to eq("Fixing Bundler's Dependency Resolution Algorithm")
      expect(articles.first.author).to eq("Dependabot")
      expect(articles.first.description).to eq("A bug leads to a journey into the resolution logic of Bundler (and a fix that speeds things up immensely).")
      expect(articles.first.url).to eq("https://dependabot.com/blog/improving-dependency-resolution-in-bundler")
    end
  end

end

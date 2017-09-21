require 'spec_helper'

RSpec.describe NewsTracker::RssFeed do

  # TODO integrate vcr
  describe '#create_article_instances_from_hashes' do
    let(:url){[
        'http://rubyweekly.com/rss/1b38al0g',
        'http://javascriptweekly.com/rss/221bj275',
        'https://nodeweekly.com/rss/'
      ]}

    context "when you select 'ruby'" do
      it "should fetch the articles and save them as an array of  NewsTracker::Article instances" do
        NewsTracker::Article.clear_all
        VCR.use_cassette('ruby-rss-feed') do
          NewsTracker::RssFeed.new(url[0]).create_article_instances_from_hashes
        end
        articles = NewsTracker::Article.all

        expect(articles).to be_a(Array)
        expect(articles.first).to be_an_instance_of(NewsTracker::Article)
        # expect(articles.first.title).to eq("The Limits of Copy-on-Write: How Ruby Allocates Memory")
        # expect(articles.first.author).to eq("Brandur Leach")
        # expect(articles.first.description).to eq("How heap and object allocation work in Ruby, often leading to bloated sub-processes, and what’s on the roadmap to help.")
        # expect(articles.first.url).to eq("https://brandur.org/ruby-memory")
      end
    end

    context "when you select 'js'" do
      it "should fetch the articles and save them as an array of  NewsTracker::Article instances" do
        NewsTracker::Article.clear_all
        VCR.use_cassette('js-rss-feed') do
          NewsTracker::RssFeed.new(url[1]).create_article_instances_from_hashes
        end
        articles = NewsTracker::Article.all

        expect(articles).to be_a(Array)
        expect(articles.first).to be_an_instance_of(NewsTracker::Article)
        # expect(articles.first.title).to eq("The Limits of Copy-on-Write: How Ruby Allocates Memory")
        # expect(articles.first.author).to eq("Brandur Leach")
        # expect(articles.first.description).to eq("How heap and object allocation work in Ruby, often leading to bloated sub-processes, and what’s on the roadmap to help.")
        # expect(articles.first.url).to eq("https://brandur.org/ruby-memory")
      end
    end

    context "when you select 'node'" do
      it "should fetch the articles and save them as an array of  NewsTracker::Article instances" do
        NewsTracker::Article.clear_all
        VCR.use_cassette('node-rss-feed') do
          NewsTracker::RssFeed.new(url[2]).create_article_instances_from_hashes
        end
        articles = NewsTracker::Article.all

        expect(articles).to be_a(Array)
        expect(articles.first).to be_an_instance_of(NewsTracker::Article)
        # expect(articles.first.title).to eq("The Limits of Copy-on-Write: How Ruby Allocates Memory")
        # expect(articles.first.author).to eq("Brandur Leach")
        # expect(articles.first.description).to eq("How heap and object allocation work in Ruby, often leading to bloated sub-processes, and what’s on the roadmap to help.")
        # expect(articles.first.url).to eq("https://brandur.org/ruby-memory")
      end
    end

  end

end

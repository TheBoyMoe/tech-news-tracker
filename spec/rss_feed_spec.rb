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
        expect(articles.first.title).to eq("Ruby 2.4.2 Released With Multiple Security Fixesbuffer under-run vuln in Kernel.sprintf")
        expect(articles.first.author).to eq("ruby-lang.org")
        expect(articles.first.description).to eq("The vulnerabilities include a buffer under-run vuln in Kernel.sprintf and RubyGems issues. Ruby 2.2.8 and 2.3.5 are also out for the same reason.")
        expect(articles.first.url).to eq("https://www.ruby-lang.org/en/news/2017/09/14/ruby-2-4-2-released/")
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
        expect(articles.first.title).to eq("How Memory Management Works in JavaScript")
        expect(articles.first.author).to eq("Alexander Zlatkov")
        expect(articles.first.description).to eq(".. and how to handle 4 common memory leaks. A good primer for anyone not familiar with the depths of memory management.")
        expect(articles.first.url).to eq("https://blog.sessionstack.com/how-javascript-works-memory-management-how-to-handle-4-common-memory-leaks-3f28b94cfbec")
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
        expect(articles.first.title).to eq("Paul Irish on Debugging in 2017 with Node.js")
        expect(articles.first.author).to eq("Node Summit")
        # expect(articles.first.description).to eq("Paul Irish demonstrates improved workflows for debugging, profiling and understanding your app using... the DevTools protocol. He also shares more advanced techniques for automating and monitoring Node.")
        expect(articles.first.url).to eq("https://nodeweekly.com/link/25574/rss")
      end
    end

  end

end

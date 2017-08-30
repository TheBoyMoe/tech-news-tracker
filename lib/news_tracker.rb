require "news_tracker/version"
require 'open-uri'
require 'nokogiri'
require 'rss'
require 'sqlite3'

DB = {:conn => SQLite3::Database.new('db/articles.db')}

module NewsTracker
  require 'news_tracker/rss_feed'
  require 'news_tracker/menu/main'
  require 'news_tracker/menu/list'
  require 'news_tracker/cli'
  require 'news_tracker/article'
end

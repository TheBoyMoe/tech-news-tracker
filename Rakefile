require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :db do

  desc 'migrate changes to the database'
  task :migrate => :environment do
    NewsTracker::Article.create_table
  end

end

desc 'load the environment'
  task :environment do
    require_relative './lib/news_tracker'
  end

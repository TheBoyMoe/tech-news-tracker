require 'simplecov'
SimpleCov.start

require "bundler/setup"
require "news_tracker"
require "pry"
require 'vcr'


DB[:conn] = SQLite3::Database.new ":memory:"

# vcr config
VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # vcr config
  # config.around(:each) do |example|
  #   VCR.use_cassette("rss-feeds") do
  #     example.run
  #   end
  # end

  # config DB[:conn] global before/after:
  # config.before(:each) do
  #   if Article.respond_to?(:create_table)
  #     Article.create_table
  #   else
  #     DB[:conn].execute("DROP TABLE IF EXISTS articles")
  #     DB[:conn].execute("CREATE TABLE IF NOT EXISTS articles (id INTEGER PRIMARY KEY, title TEXT, author TEXT, description TEXT, url TEXT)")
  #   end
  # end
  #
  # config.after(:each) do
  #     DB[:conn].execute("DROP TABLE IF EXISTS articles")
  # end

end

def suppress_output
  begin
    original_stderr = $stderr.clone
    original_stdout = $stdout.clone
    $stderr.reopen(File.new('/dev/null', 'w'))
    $stdout.reopen(File.new('/dev/null', 'w'))
    retval = yield
  rescue Exception => e
    $stdout.reopen(original_stdout)
    $stderr.reopen(original_stderr)
    raise e
  ensure
    $stdout.reopen(original_stdout)
    $stderr.reopen(original_stderr)
  end
  retval
end

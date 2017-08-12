require "spec_helper"

RSpec.describe NewsTracker do
  it "has a version number" do
    expect(NewsTracker::VERSION).not_to be nil
  end

  context NewsTracker::CLI do
    let(:cli){NewsTracker::CLI.new}
    let(:titles){[
      "1. Fixing bundler's dependency resolution algorithm",
      "2. A crash course in analysing memory usage in Ruby",
      "3. Redis 4.0 now on RedisGreen",
      "4. Looking into CSFR protection in Rails",
      "5. Advanced anumeration in Ruby",
      "6. Why it's just lazy to bad mouth Rails",
      "7. Effectively managing localization files in Rails"
    ]}

    describe '#greet_user' do
      it "Greet the user when the app launches" do
        expect{cli.greet_user}.to output("------------------------------------------------------------------\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n------------------------------------------------------------------\n").to_stdout
      end
    end

    describe '#list_options' do
      it "List the available options" do
        expect{cli.list_options}.to output("  Select a topic to list the latest articles\n  Type 'ruby' for Ruby and Rails news\n  Type 'js' for Javascript news\n  Type 'node' for NodeJS news\n  Type 'exit' to quit\n\n").to_stdout
      end
    end

    describe '#print_articles' do
      it "print a list of the latest article titles" do
        topic = 'ruby'
        expect{cli.print_articles(topic)}.to output(
        "Displaying ruby news:\n------------------------------------------------------------------\n  1. Fixing bundler's dependency resolution algorithm\n  2. A crash course in analysing memory usage in Ruby\n  3. Redis 4.0 now on RedisGreen\n  4. Looking into CSFR protection in Rails\n  5. Advanced anumeration in Ruby\n  6. Why it's just lazy to bad mouth Rails\n  7. Effectively managing localization files in Rails\n------------------------------------------------------------------\n").to_stdout
      end
    end

    describe '#prompt_user_to_select_article' do
      it "prompt user to pick an article or return to the previous menu" do
        expect{cli.prompt_user_to_select_article}.to output("  Enter a number between 1-7 to pick an article or\n  type 'menu' to return to the options menu or 'exit' to quit\n").to_stdout
      end
    end

    describe '#prompt_user_to_take_action' do
      it "prompt user to take action following the display of article details" do
        expect{cli.prompt_user_to_take_action}.to output("Type 'list' to review the list again, 'menu' to return to the options or 'exit' to quit\n").to_stdout
      end
    end

  end

end

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
        expect{cli.list_options}.to output("  Select an option\n  '1' for Ruby and Rails news\n  '2' for Javascript news\n  '3' for NodeJS news\n  Type 'exit' to quit\n\n").to_stdout
      end
    end

    describe '#print_list' do
      it "print a list of the latest article titles" do
        expect{cli.print_list}.to output(
        "------------------------------------------------------------------\n  1. Fixing bundler's dependency resolution algorithm\n  2. A crash course in analysing memory usage in Ruby\n  3. Redis 4.0 now on RedisGreen\n  4. Looking into CSFR protection in Rails\n  5. Advanced anumeration in Ruby\n  6. Why it's just lazy to bad mouth Rails\n  7. Effectively managing localization files in Rails\n------------------------------------------------------------------\n").to_stdout
      end
    end

    describe '#prompt_user' do
      it "prompt user to pick an article or return to the previous menu" do
        expect{cli.prompt_user}.to output("  Pick an article or type 'menu' to return to the options menu\n").to_stdout
      end
    end

  end

end

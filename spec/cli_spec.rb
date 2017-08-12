require "spec_helper"

RSpec.describe NewsTracker do
  it "has a version number" do
    expect(NewsTracker::VERSION).not_to be nil
  end

  context NewsTracker::CLI do
    let(:cli){NewsTracker::CLI.new}

    describe '#greet_user' do
      it "Greet the user when the app launches" do
        expect{cli.greet_user}.to output("------------------------------------------------------------------\n  Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n------------------------------------------------------------------\n").to_stdout
      end
    end

    describe '#list_options' do
      it "List the available options" do
        expect{cli.list_options}.to output("  Select an option\n  '1' for Ruby news\n  '2' for Javascript news\n  '3' for NodeJS news\n  Type 'exit' to quit\n\n").to_stdout
      end
    end

  end

end

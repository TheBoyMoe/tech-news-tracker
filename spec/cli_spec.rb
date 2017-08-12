require "spec_helper"

RSpec.describe NewsTracker do
  it "has a version number" do
    expect(NewsTracker::VERSION).not_to be nil
  end

  context NewsTracker::CLI do
    let(:cli){NewsTracker::CLI.new}

    describe '#greet_user' do
      it "Greet the user when the app launches and display a list of options" do
        expect{cli.greet_user}.to output("--------------------------------------------------------------------\n   Welcome to News Tracker - Ruby/Rails/Javascript and Node News!\n--------------------------------------------------------------------\n").to_stdout
      end
    end

    # describe '#list_options' do
    #   it "List the options the user can make" do
    #     expect{cli.list_options}.to output().to_stdout
    #
    #   end
    # end
  end

end

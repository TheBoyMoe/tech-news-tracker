require "spec_helper"
# require 'stringio'

RSpec.describe NewsTracker::Menu::Main do

  describe '#display' do
    context "when the app is launched" do
      it "return a string that includes 'Select a topic to list the latest articles'" do
        expect(subject.display).to be_a(String)
        expect(subject.display).to include('Select a topic to list the latest articles')
      end
    end
  end

end

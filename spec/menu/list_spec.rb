require "spec_helper"
# require 'stringio'

RSpec.describe NewsTracker::Menu::List do

  let(:list_menu){NewsTracker::Menu::List.new('ruby')}

  describe '#initialize' do
    context "when a user selects 'ruby' article list" do

      it "sets the '@list_type' to 'ruby'" do
        expect(list_menu.list_type).to eq('ruby')
      end

      it "populates the article cache with instances of NewsTracker::Article" do
        expect(NewsTracker::Article.all).to be_a(Array)
        expect(NewsTracker::Article.all.first).to be_a_instance_of(NewsTracker::Article)
      end

    end
  end

  describe '#display' do
    context "when a user selects 'ruby' article list" do

      it "returns a string of the article list, that includes 'Displaying ruby news:'" do
        expect(list_menu.display).to be_a(String)
        expect(list_menu.display).to include('Displaying ruby news:')
      end

    end
  end

end

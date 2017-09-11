require "spec_helper"
require 'stringio'


RSpec.describe NewsTracker::Menu::Main do
  # It feels like when can make this spec a bit more dry
  # by taking out of the various contenxt the before block
  # as follows

  # before do
  #   $stdin = command
  #   subject.read_menu_command
  # end
  #
  # after do
  #   $stdin = STDIN
  # end

  # and then inside the contenxts do the following:
  # let(:command) { StringIO.new("ruby\n") }

  # to keep the convention use:
  #
  # describe #process_command do
  # end
  #
  describe 'process the user input' do

    context "the user selects the 'ruby' article list option" do
      # can be removed and just add a let, see comment on top of file
      before do
        $stdin = StringIO.new("ruby\n")
      end

      after do
        $stdin = STDIN
      end

      it "switch the current menu to 'NewsTracker::Menu::List'" do
        # can be done in before block, see comment at top of file
        subject.read_menu_command
        current_menu = subject.process_command

        expect(current_menu).to be_a(NewsTracker::Menu::List)
      end
    end

    context "the user selects 'archive' option" do
      before do
        $stdin = StringIO.new("archive\n")
      end

      after do
        $stdin = STDIN
      end

      it "switch the current menu to 'NewsTracker::Menu::Archive'" do
        subject.read_menu_command
        current_menu = subject.process_command

        expect(current_menu).to be_a(NewsTracker::Menu::Archive)
      end
    end

    context "the user selects 'exit'" do
      before do
        $stdin = StringIO.new("exit\n")
      end

      after do
        $stdin = STDIN
      end

      it "terminates app and displays 'Goodbye' message" do
        subject.read_menu_command

        expect{subject.process_command}.to output("Goodbye!\n").to_stdout
      end
    end

    context "the user enters an unknown command" do
      before do
        $stdin = StringIO.new("unknown\n")
      end

      after do
        $stdin = STDIN
      end

      it "stay on the main menu, 'NewsTracker::Menu::Main', and output message 'Not a valid command'" do
        subject.read_menu_command
        current_menu = subject.process_command

        expect{subject.process_command}.to output("Not a valid command\n").to_stdout
        expect(current_menu).to be_a(NewsTracker::Menu::Main)
      end
    end

  end

end

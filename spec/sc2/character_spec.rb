require 'spec_helper'

describe SC2::Character do
  describe '.initialize' do
    let(:character) { SC2::Character.new(@options) }

    before do
      @options = {}
    end

    it 'should store the id' do
      @options = {:id => 5}
      character.id.should == 5
    end

    it 'should store the realm' do
      @options = {:realm => "somewhere"}
      character.realm.should == "somewhere"
    end

    it 'should store the display_name' do
      @options = {:display_name => "display me"}
      character.display_name.should == "display me"
    end

    it "should store the clan_name" do
      @options = {:clan_name => "clan name"}
      character.clan_name.should == "clan name"
    end

    it "should store the clan_tag" do
      @options = {:clan_tag => "clan tag"}
      character.clan_tag.should == "clan tag"
    end

    it "should store the profile_path" do
      @options = {:profile_path => "/some/path"}
      character.profile_path.should == "/some/path"
    end
  end
end
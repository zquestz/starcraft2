require 'spec_helper'

describe Starcraft2::Achievement do
  describe '#build' do
    let(:achievements) { Starcraft2::Achievement.build(@achievements) }

    before do
      VCR.use_cassette('achievements') do
        @achievements = JSON.parse(HTTParty.get('https://us.battle.net/api/sc2/data/achievements').body)
      end
    end

    it 'should build an array of achievements' do
      achievements.class.should == Array
      achievements.each do |a|
        a.class.should == Starcraft2::Achievement
      end
    end
  end

  describe '.initialize' do
    let(:achievement) { Starcraft2::Achievement.new(@options) }

    before do
      @options = {}
    end

    it 'should import the first achievement' do
      VCR.use_cassette('achievements') do
        @achievement = Starcraft2::Achievement.build(JSON.parse(HTTParty.get('https://us.battle.net/api/sc2/data/achievements').body)).first
      end

      @achievement.title.should == 'FFA Destroyer'
      @achievement.description.should == 'Win a Free-For-All Unranked game as each race option.'
      @achievement.achievement_id.should == 91475320766632
      @achievement.category_id.should == 4325391
      @achievement.points.should == 10
      @achievement.icon.x.should == 0
      @achievement.icon.y.should == -375
      @achievement.icon.w.should == 75
      @achievement.icon.h.should == 75
      @achievement.icon.offset.should == 45
      @achievement.icon.url.should == 'http://media.blizzard.com/sc2/achievements/5-75.jpg'
    end

    it 'should store the title' do
      @options = {:title => 'Test Title'}
      achievement.title.should == 'Test Title'
    end

    it 'should store the description' do
      @options = {:description => 'Description'}
      achievement.description.should == 'Description'
    end

    it 'should store the achievement id' do
      @options = {:achievement_id => 5}
      achievement.achievement_id.should == 5
    end

    it 'should store the category id' do
      @options = {:category_id => 10}
      achievement.category_id.should == 10
    end

    it 'should store the points' do
      @options = {:points => 5}
      achievement.points.should == 5
    end

    it 'should store the icon data' do
      @options = {:icon => {'x' => 1, 'y' => 2, 'w' => 3, 'h' => 4, 'offset' => 0, 'url' => 'https://example.com'}}
      achievement.icon.x.should == 1
      achievement.icon.y.should == 2
      achievement.icon.w.should == 3
      achievement.icon.h.should == 4
      achievement.icon.offset.should == 0
      achievement.icon.url.should == 'https://example.com'
    end
  end
end

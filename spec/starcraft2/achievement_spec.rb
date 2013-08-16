require 'spec_helper'

describe Starcraft2::Achievement do
  describe '.initialize' do
    let(:achievement) { Starcraft2::Achievement.new(@options) }

    before do
      @options = {
        'title' => 'Test Title',
        'description' => 'Description',
        'achievementId' => 5,
        'categoryId' => 10,
        'points' => 5,
        'icon' => {'x' => 1, 'y' => 2, 'w' => 3, 'h' => 4, 'offset' => 0, 'url' => 'https://example.com'}
      }
    end

    it 'should store attributes as underscored' do
      achievement.title.should == 'Test Title'
      achievement.description.should == 'Description'
      achievement.achievement_id.should == 5
      achievement.category_id.should == 10
      achievement.points.should == 5
      achievement.icon.x.should == 1
      achievement.icon.y.should == 2
      achievement.icon.w.should == 3
      achievement.icon.h.should == 4
      achievement.icon.offset.should == 0
      achievement.icon.url.should == 'https://example.com'
    end
  end

  describe '#build' do
    let(:achievements) { Starcraft2::Achievement.build(@items) }

    before do
      @items = {
        'achievements' => [
          {'title' => 'Test Title'},
          {'title' => 'Another'}
        ]
      }
    end

    it 'should build an array of achievements' do
      achievements.class.should == Array
      achievements.each do |a|
        a.class.should == Starcraft2::Achievement
      end
    end

    it 'should build items using new' do
      @items['achievements'].each do |i|
        Starcraft2::Achievement.should_receive(:new).with(i)
      end

      achievements
    end

    it 'should import the achievements from blizzard' do
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
  end
end

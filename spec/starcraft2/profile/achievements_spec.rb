require 'spec_helper'

describe Starcraft2::Profile::Achievements do
  let(:achievements) { Starcraft2::Profile::Achievements.new(@options) }

  before do
    @options = {}
  end

  it 'should store points' do
    @options = {
      :points => {
        :total_points => 3420,
        :category_points => {
          '4325382' => 0,
          '4325380' => 80,
          '4325408' => 0,
          '4325379' => 1560,
          '4325410' => 1280,
          '4325377' => 500
        }
      }
    }

    achievements.points.class.should == Starcraft2::Profile::Points
    achievements.points.total_points.should == 3420
    achievements.points.category_points.should == @options[:points][:category_points]
  end

  it 'should store achievement_items' do
    @options = {
      :achievements => [
        {
          :achievement_id => 91475035553845,
          :completion_date => 1365790265
        },
        {
          :achievement_id => 91475320768475,
          :completion_date => 1365392587
        },
        {
          :achievement_id => 91475320768585,
          :completion_date => 1364634012
        }
      ]
    }

    achievements.achievements.class.should == Array

    a1 = achievements.achievements.first
    a1.class.should == Starcraft2::Profile::AchievementItem
    a1.achievement_id.should == 91475035553845
    a1.completion_date.should == 1365790265

    a2 = achievements.achievements[1]
    a2.class.should == Starcraft2::Profile::AchievementItem
    a2.achievement_id.should == 91475320768475
    a2.completion_date.should == 1365392587

    a3 = achievements.achievements[2]
    a3.class.should == Starcraft2::Profile::AchievementItem
    a3.achievement_id.should == 91475320768585
    a3.completion_date.should == 1364634012
  end
end

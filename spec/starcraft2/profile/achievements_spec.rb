require 'spec_helper'

describe Starcraft2::Profile::Achievements do
  let(:achievements) { Starcraft2::Profile::Achievements.new(@options) }

  it 'should store underscored attributes' do
    @options = {
      :points => {
        :total_points => 3420,
        :category_points => {
          '4325382' => 0,
          '4325380' => 80
        }
      },
      :achievements => [
        {
          :achievement_id => 91475035553845,
          :completion_date => 1365790265
        }
      ]
    }

    achievements.points.class.should == Starcraft2::Profile::Points
    achievements.points.total_points.should == 3420
    achievements.points.category_points.should == @options[:points][:category_points]

    achievements.achievements.class.should == Array

    achievement_item = achievements.achievements.first
    achievement_item.class.should == Starcraft2::Profile::AchievementItem
    achievement_item.achievement_id.should == 91475035553845
    achievement_item.completion_date.should == 1365790265
  end

  it 'should store camelCased attributes as underscored' do
    @options = {
      'points' => {
        'totalPoints' => 3420,
        'categoryPoints' => {
          '4325382' => 0,
          '4325380' => 80
        }
      },
      'achievements' => [
        {
          'achievementId' => 91475035553845,
          'completionDate' => 1365790265
        }
      ]
    }

    achievements.points.class.should == Starcraft2::Profile::Points
    achievements.points.total_points.should == 3420
    achievements.points.category_points.should == @options['points']['categoryPoints']

    achievements.achievements.class.should == Array

    achievement_item = achievements.achievements.first
    achievement_item.class.should == Starcraft2::Profile::AchievementItem
    achievement_item.achievement_id.should == 91475035553845
    achievement_item.completion_date.should == 1365790265
  end
end
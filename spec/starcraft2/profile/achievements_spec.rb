require 'spec_helper'

describe Starcraft2::Profile::Achievements do
  describe '.initialize' do
    let(:achievements) { Starcraft2::Profile::Achievements.new(@options) }

    before do
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
    end

    it 'should store attributes as underscored' do
      achievements.points.class.should == Starcraft2::Profile::Points
      achievements.points.total_points.should == 3420
      achievements.points.category_points.should == @options['points']['categoryPoints']

      achievements.achievements.class.should == Array

      achievement_item = achievements.achievements.first
      achievement_item.class.should == Starcraft2::Profile::AchievementItem
      achievement_item.achievement_id.should == 91475035553845
      achievement_item.completion_date.should == 1365790265
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options, {:points => Starcraft2::Profile::Points}, {:achievements => Starcraft2::Profile::AchievementItem})

      achievements
    end
  end
end
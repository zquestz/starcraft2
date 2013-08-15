require 'spec_helper'

describe Starcraft2::Profile::Achievements do
  let(:achievements) { Starcraft2::Profile::Achievements.new(@options) }

  before do
    @options = {}
  end

  it 'should store points' do
    @options = {:points => {
      :total_points => 3420,
      :categoryPoints => {
        "4325382" => 0,
        "4325380" => 80,
        "4325408" => 0,
        "4325379" => 1560,
        "4325410" => 1280,
        "4325377" => 500
      }
    }}
    achievements.points.total_points.should == 3420
  end

  it 'should store achievement_items' do
    @options = {:achievements => [{ :achievement_id => 91475035553845, :completion_date => 1365790265},
                                  { :achievement_id => 91475320768475, :completion_date => 1365392587},
                                  { :achievement_id => 91475320768585, :completion_date => 1364634012}]}

    achievements.achievements.class.should == Array
    achievements.achievements.first.class.should == Starcraft2::Profile::AchievementItem
    achievements.achievements.first.achievement_id.should == 91475035553845
    achievements.achievements.first.completion_date.should == 1365790265
  end
end

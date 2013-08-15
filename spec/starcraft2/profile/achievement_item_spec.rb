require 'spec_helper'

describe Starcraft2::Profile::AchievementItem do
  describe '.initialize' do
    let(:achievement_item) { Starcraft2::Profile::AchievementItem.new(@options) }

    it 'should store attributes as underscored' do
      @options = {'achievementId' => 1, 'completionDate' => 13333333}

      achievement_item.achievement_id.should == 1
      achievement_item.completion_date.should == 13333333
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options)

      achievement_item
    end
  end

  describe '#build' do
    let(:achievement_items) { Starcraft2::Profile::AchievementItem.build(@items) }

    before do
      @items = [
        {'achievementId' => 1, 'completionDate' => 13333333},
        {'achievementId' => 2, 'completionDate' => 13333334}
      ]
    end

    it 'should build multiple achievement items' do
      achievement_items.class.should == Array

      a1 = achievement_items.first
      a1.class.should == Starcraft2::Profile::AchievementItem
      a1.achievement_id.should == 1
      a1.completion_date.should == 13333333

      a2 = achievement_items.last
      a2.class.should == Starcraft2::Profile::AchievementItem
      a2.achievement_id.should == 2
      a2.completion_date.should == 13333334
    end

    it 'should build items using new' do
      Starcraft2::Profile::AchievementItem.should_receive(:new).twice

      achievement_items
    end
  end
end
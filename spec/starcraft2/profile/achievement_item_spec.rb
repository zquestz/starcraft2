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
        {'achievementId' => 1},
        {'achievementId' => 2}
      ]
    end

    it 'should build multiple achievement items' do
      achievement_items.class.should == Array
      achievement_items.each do |ai|
        ai.class.should == Starcraft2::Profile::AchievementItem
      end
    end

    it 'should build items using new' do
      @items.each do |i|
        Starcraft2::Profile::AchievementItem.should_receive(:new).with(i)
      end

      achievement_items
    end
  end
end
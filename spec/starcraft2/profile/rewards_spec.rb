require 'spec_helper'

describe Starcraft2::Profile::Rewards do
  describe '.initialize' do
    let(:rewards) { Starcraft2::Profile::Rewards.new(@options) }

    before do
      @options = {
        'selected' => [18730036, 2009110693, 2359737029, 3319454886],
        'earned' => [19065053, 97993138, 171155159, 199895074, 354595443, 367294557, 382993515, 414497095, 540410724]
      }
    end

    it 'should store attributes as underscored' do
      rewards.selected.should == [18730036, 2009110693, 2359737029, 3319454886]
      rewards.earned.should == [19065053, 97993138, 171155159, 199895074, 354595443, 367294557, 382993515, 414497095, 540410724]
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options)

      rewards
    end
  end
end

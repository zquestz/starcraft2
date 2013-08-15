require 'spec_helper'

describe Starcraft2::Profile::Rewards do
  let(:rewards) { Starcraft2::Profile::Rewards.new(@options) }

  before do
    @options = {}
  end

  it 'should store selected' do
    @options = {:selected => [18730036, 2009110693, 2359737029, 3319454886]}
    rewards.selected.should == [18730036, 2009110693, 2359737029, 3319454886]
  end

  it 'should store earned' do
    @options = {:earned => [19065053, 97993138, 171155159, 199895074, 354595443, 367294557, 382993515, 414497095, 540410724]}
    rewards.earned.should == [19065053, 97993138, 171155159, 199895074, 354595443, 367294557, 382993515, 414497095, 540410724]
  end
end

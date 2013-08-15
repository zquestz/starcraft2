require 'spec_helper'

describe Starcraft2::Profile::Campaign do
  let(:campaign) { Starcraft2::Profile::Campaign.new(@options) }

  before do
    @options = {}
  end

  describe '.initialize' do
    it 'should store wol' do
      @options = {:wol => 'BRUTAL'}
      campaign.wol.should == 'BRUTAL'
    end

    it 'should store hots' do
      @options = {:hots => 'BRUTAL'}
      campaign.hots.should == 'BRUTAL'
    end
  end
end

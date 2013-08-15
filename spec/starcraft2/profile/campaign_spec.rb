require 'spec_helper'

describe Starcraft2::Profile::Campaign do
  let(:campaign) { Starcraft2::Profile::Campaign.new(@options) }

  before do
    @options = {}
  end

  describe '.initialize' do
    it 'should store the attributes' do
      @options = {'wol' => 'BRUTAL', 'hots' => 'BRUTAL'}

      campaign.wol.should == 'BRUTAL'
      campaign.hots.should == 'BRUTAL'
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options)

      campaign
    end
  end
end
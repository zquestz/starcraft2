require 'spec_helper'

describe Starcraft2::Icon do
  describe '.initialize' do
    let(:icon) { Starcraft2::Icon.new(@options) }

    before do
      @options = {'x' => 5, 'y' => 6, 'w' => 7, 'h' => 8, 'offset' => 0, 'url' => 'https://example.com'}
    end

    it 'should store attributes as underscored' do
      icon.x.should == 5
      icon.y.should == 6
      icon.w.should == 7
      icon.h.should == 8
      icon.offset.should == 0
      icon.url.should == 'https://example.com'
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options)

      icon
    end
  end
end
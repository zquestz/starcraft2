require 'spec_helper'

describe Starcraft2::Icon do
  describe '.initialize' do
    let(:icon) { Starcraft2::Icon.new(@options) }

    before do
      @options = {}
    end

    it 'should store x' do
      @options = {:x => 5}
      icon.x.should == 5
    end

    it 'should store y' do
      @options = {:y => 6}
      icon.y.should == 6
    end

    it 'should store w' do
      @options = {:w => 7}
      icon.w.should == 7
    end

    it 'should store h' do
      @options = {:h => 8}
      icon.h.should == 8
    end

    it 'should store the offset' do
      @options = {:offset => 0}
      icon.offset.should == 0
    end

    it 'should store the url' do
      @options = {:url => 'https://example.com'}
      icon.url.should == 'https://example.com'
    end
  end
end
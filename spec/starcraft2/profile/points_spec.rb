require 'spec_helper'

describe Starcraft2::Profile::Points do
  describe '.initialize' do
    let(:points) { Starcraft2::Profile::Points.new(@options) }

    before do
      @options = {'totalPoints' => 5, 'categoryPoints' => 10}
    end

    it 'should store attributes as underscored' do
      points.total_points.should == 5
      points.category_points.should == 10
    end

    it 'should use Stracraft2::Utils.load to populate the model' do
      Starcraft2::Utils.should_receive(:load).with(anything, @options)

      points
    end
  end
end
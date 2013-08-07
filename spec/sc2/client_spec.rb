require "spec_helper"

describe SC2::Client do
  let(:client) { SC2::Client.new(@options)}

  before do
    @options = {:host => 'us.battle.net'}
  end

  context 'url constants' do
    it 'should store the achievements url' do
      SC2::Client::ACHIEVEMENTS_PATH.should == '/api/sc2/data/achievements'
    end
  end

  it 'should store the locale' do
    @options = { :locale => 'en_US' }
    client.locale.should == 'en_US'
  end

  it 'should store the host' do
    @options = { :host => 'someserver.com'}
    client.host.should == 'someserver.com'
  end

  it 'should return an array of achievements' do
    VCR.use_cassette('achievements') do
      client.achievements.class.should == Array
    end
  end

  it 'should return items of type SC2::Achievement' do
    VCR.use_cassette('achievements') do
      client.achievements.first.class.should == SC2::Achievement
    end
  end
end

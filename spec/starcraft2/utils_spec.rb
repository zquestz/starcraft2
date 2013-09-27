require 'spec_helper'

describe Starcraft2::Utils do
  describe '#underscore' do
    it 'should underscore a string' do
      Starcraft2::Utils.underscore('FooBar').should == 'foo_bar'
    end
  end

  describe '#load' do
    it 'should load attributes in a class' do
      icon = Starcraft2::Icon.new()
      icon.x.should == nil
      icon.y.should == nil

      Starcraft2::Utils.load(icon, {:x => 2, :y => 3})
      icon.x.should == 2
      icon.y.should == 3
    end

    it 'should convert camelCased to underscored' do
      career = Starcraft2::Profile::Career.new()
      career.protoss_wins.should == nil

      Starcraft2::Utils.load(career, {'protossWins' => 5})
      career.protoss_wins.should == 5
    end

    it 'should allow a key to initialize another class' do
      member = Starcraft2::Member.new()
      member.points.should == nil
      member.character.should == nil

      Starcraft2::Utils.load(member, {:points => 10, :character => {:display_name => 'steve'}}, {:character => Starcraft2::Character})
      member.points.should == 10
      member.character.class.should == Starcraft2::Character
      member.character.display_name.should == 'steve'
    end

    it 'should allow a key to build another class' do
      ladders = Starcraft2::Profile::Ladders.new()
      ladders.current_season.should == nil

      options = {
        'currentSeason' => [
          {'ladder' => [{'ladderName' => 'Shuttle Tango'}]},
          {'ladder' => [{'ladderName' => 'Torrasque Upsilon'}]}
        ]
      }
      Starcraft2::Utils.load(ladders, options, {}, {:current_season => Starcraft2::Profile::DetailedSeason})
      ladders.current_season.each do |season|
        season.class.should == Starcraft2::Profile::DetailedSeason
      end
      ladders.current_season.first.ladder.first.ladder_name.should == 'Shuttle Tango'
      ladders.current_season.last.ladder.first.ladder_name.should == 'Torrasque Upsilon'
    end
  end

  describe '#get_json' do
    let(:success) { {'code' => 200, 'message' => 'success', 'status' => 'nok'} }
    let(:error) { {'code' => 500, 'message' => 'error', 'status' => 'nok'} }
    let(:not_found) { {'code' => 404, 'message' => 'not found', 'status' => 'nok'} }

    describe 'HTTP 200' do
      let(:request) { HTTParty::Request.new Net::HTTP::Get, '/' }
      let(:response) { Net::HTTPOK.new('1.1', 200, 'OK') }

      it 'should return the parsed json body' do
        response.stub(:body).and_return(success.to_json)
        response_lambda = lambda { success.to_json }

        Starcraft2::Utils.get_json do
          HTTParty::Response.new(request, response, response_lambda)
        end.should == success
      end

      context 'json contains code 404' do
        it 'should throw a NotFoundError' do
          response.stub(:body).and_return(not_found.to_json)
          response_lambda = lambda { not_found.to_json }

          expect {
            Starcraft2::Utils.get_json do
              HTTParty::Response.new(request, response, response_lambda)
            end
          }.to raise_error(Starcraft2::NotFoundError, anything)
        end
      end

      context 'json contains code 500' do
        it 'should throw an ApiError' do
          response.stub(:body).and_return(error.to_json)
          response_lambda = lambda { error.to_json }

          expect {
            Starcraft2::Utils.get_json do
              HTTParty::Response.new(request, response, response_lambda)
            end
          }.to raise_error(Starcraft2::ApiError, anything)
        end
      end
    end

    describe 'HTTP 404' do
      let(:request) { HTTParty::Request.new Net::HTTP::Get, '/' }
      let(:response) { Net::HTTPNotFound.new('1.1', 404, 'OK') }

      it 'should throw a NotFoundError' do
        response.stub(:body).and_return(not_found.to_json)
        response_lambda = lambda { not_found.to_json }

        expect {
          Starcraft2::Utils.get_json do
            HTTParty::Response.new(request, response, response_lambda)
          end
        }.to raise_error(Starcraft2::NotFoundError, anything)
      end
    end

    describe 'HTTP 500' do
      let(:request) { HTTParty::Request.new Net::HTTP::Get, '/' }
      let(:response) { Net::HTTPInternalServerError.new('1.1', 500, 'OK') }

      it 'should throw an ApiError' do
        response.stub(:body).and_return(error.to_json)
        response_lambda = lambda { error.to_json }

        expect {
          Starcraft2::Utils.get_json do
            HTTParty::Response.new(request, response, response_lambda)
          end
        }.to raise_error(Starcraft2::ApiError, anything)
      end
    end
  end
end

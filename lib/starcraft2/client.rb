module Starcraft2
  class Client
    ACHIEVEMENTS_PATH = '/api/sc2/data/achievements'
    REWARDS_PATH = '/api/sc2/data/rewards'
    LADDER_PATH = '/api/sc2/ladder/'

    attr_accessor :locale, :host

    def initialize(options = {})
      options.each do |k, v|
        self.send(:"#{k}=", v)
      end

      self.host = 'us.battle.net' if self.host.nil?
    end

    def profile(options = {})
      if (args = [:character_name, :id, :realm] - options.keys).empty?
        Profile.build(self, profile_data(options))
      else
        raise MissingArgumentsError, "Missing Keys: #{args.map {|i| ":#{i}"}.join(', ')}"
      end
    end

    def achievements
      Achievement.build(achievements_data)
    end

    def rewards
      Reward.build(rewards_data)
    end

    def ladder(id)
      Ladder.build(ladder_data(id))
    end

    def grandmaster_ladder
      ladder('grandmaster')
    end

    def last_grandmaster_ladder
      ladder('grandmaster/last')
    end

    private

    def matches(options = {})
      Profile::Match.build(match_data(options))
    end

    def ladders(options = {})
      Profile::Ladders.new(ladders_data(options))
    end

    def profile_data(options)
      get_json do
        HTTParty.get(profile_url(options))
      end
    end

    def profile_url(options)
      'https://' + host + profile_path(options) + locale_param
    end

    def profile_path(options)
      "/api/sc2/profile/#{options[:id]}/#{options[:realm]}/#{options[:character_name]}/" + locale_param
    end

    def match_data(options)
      get_json do
        HTTParty.get(match_url(options))
      end
    end

    def ladders_data(options)
      get_json do
        HTTParty.get(ladders_url(options))
      end
    end

    def match_url(options)
      'https://' + host + profile_path(options) + 'matches' + locale_param
    end

    def ladders_url(options)
      'https://' + host + profile_path(options) + 'ladders' + locale_param
    end

    def achievements_data
      get_json do
        HTTParty.get(achievements_url)
      end
    end

    def achievements_url
      'https://' + host + ACHIEVEMENTS_PATH + locale_param
    end

    def rewards_data
      get_json do
        HTTParty.get(rewards_url)
      end
    end

    def rewards_url
      'https://' + host + REWARDS_PATH + locale_param
    end

    def ladder_data(id)
      get_json do
        HTTParty.get(ladder_url(id))
      end
    end

    def ladder_url(id)
      'https://' + host + LADDER_PATH + id.to_s + locale_param
    end

    def locale_param
      locale.nil? ? '' : "?locale=#{locale}"
    end

    def get_json
      response = yield
      case response.code
        when 200
          body = JSON.parse(response.body)
          case body['code']
            when 404
              raise Starcraft2::NotFoundError, body['message'] || body['reason']
            when 500
              raise Starcraft2::ApiError, body['message'] || body['reason']
            else
              body
          end
        when 404
          raise Starcraft2::NotFoundError, 'Record not found.'
        when 500
          raise Starcraft2::ApiError, 'An API error occurred.'
      end
    end
  end
end

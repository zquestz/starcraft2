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
        Profile.build(profile_json(options))
      else
        raise MissingArgumentsError, "Missing Keys: #{args.map {|i| ":#{i}"}.join(', ')}"
      end
    end

    def achievements
      Achievement.build(achievements_json)
    end

    def rewards
      Reward.build(rewards_json)
    end

    def ladder(id)
      Ladder.build(ladder_json(id))
    end

    def grandmaster_ladder
      ladder('grandmaster')
    end

    def previous_grandmaster_ladder
      ladder('grandmaster/last')
    end

    private

    def profile_json(options)
      HTTParty.get(profile_url(options)).body
    end

    def profile_url(options)
      'https://' + host + profile_path(options) + locale_param
    end

    def profile_path(options)
      "/api/sc2/profile/#{options[:id]}/#{options[:realm]}/#{options[:character_name]}/" + locale_param
    end

    def achievements_json
      HTTParty.get(achievements_url).body
    end

    def achievements_url
      'https://' + host + ACHIEVEMENTS_PATH + locale_param
    end

    def rewards_json
      HTTParty.get(rewards_url).body
    end

    def rewards_url
      'https://' + host + REWARDS_PATH + locale_param
    end

    def ladder_json(id)
      HTTParty.get(ladder_url(id)).body
    end

    def ladder_url(id)
      'https://' + host + LADDER_PATH + id.to_s + locale_param
    end

    def locale_param
      locale.nil? ? '' : "?locale=#{locale}"
    end
  end
end

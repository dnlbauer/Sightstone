require 'rest_client'
require 'json'
require 'sightstone/modules/champion_module'
require 'sightstone/modules/summoner_module'
require 'sightstone/modules/game_module'
require 'sightstone/modules/league_module'
require 'sightstone/modules/stats_module'
require 'sightstone/modules/team_module'
require 'sightstone/modules/datadragon_module'

# This is the main class of the Sightstone gem. All calls should be perfomrmed through this class.
# @attr [String] region The default region
# @attr [String] api_key Your api key
# @attr [SummonerModule] summoner Module to call the summoners api
# @attr [ChampionModule] Champion module to call the champion api
# @attr [GameModule] Game module to call the game api
# @attr [LeagueModule] League module to call the leagues api
# @attr [StatsModule] Stats module to call the stats api
# @attr [TeamModule] Team module to call the team api
module Sightstone

class Sightstone
  
  attr_accessor :region
  attr_accessor :api_key
  attr_accessor :summoner, :champion, :game, :league, :stats, :team, :ddragon
  
  # @param api_key [String] Riot developer api key
  # @param region [String] The default region to be used. See riots dev. page for supported regions.
  def initialize(api_key, region='euw')
    @api_key = api_key
    @region = region
    
    @summoner = SummonerModule.new(self)
    @champion = ChampionModule.new(self)
    @game = GameModule.new(self)
    @league = LeagueModule.new(self)
    @stats = StatsModule.new(self)
    @team = TeamModule.new(self)
    @ddragon = DatadragonModule.new(self)
  end
end

# Base class for exceptions raised by the gem
class SightstoneApiException < Exception; end

# Raised if no or an invalid api key was passed to the api
class InvalidApiKeyException < SightstoneApiException; end

# Raised if the given developer cannot be found (api returns http error code 404)
class SummonerNotFoundException < SightstoneApiException; end

# Raised if the connection to the api failed
class SightstoneConnectionException < SightstoneApiException; end

# Raised when the RateLimit has been exceeded (api returns http error code 429)
class RateLimitExceededException < SightstoneApiException; end


end

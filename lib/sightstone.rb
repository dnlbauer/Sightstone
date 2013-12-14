require 'rest_client'
require 'JSON'
require 'sightstone/modules/champion_module'
require 'sightstone/modules/summoner_module'
require 'sightstone/modules/game_module'
require 'sightstone/modules/league_module'
require 'sightstone/modules/stats_module'
require 'sightstone/modules/team_module'

class Sightstone
  attr_accessor :region, :api_key
  attr_accessor :summoner, :champion, :game, :league, :stats, :team
  
  def initialize(api_key, region)
    @api_key = api_key
    @region = region
    
    @summoner = SummonerModule.new(self)
    @champion = ChampionModule.new(self)
    @game = GameModule.new(self)
    @league = LeagueModule.new(self)
    @stats = StatsModule.new(self)
    @team = TeamModule.new(self)
  end
end

# Error classes
class SightstoneApiException < Exception; end

class SummonerNotFoundException < SightstoneApiException; end

class SightstoneConnectionException < SightstoneApiException; end

class RateLimitExceededException < SightstoneApiException; end

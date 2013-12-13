require 'rest_client'
require 'JSON'
require 'sightstone/modules/champion_module'
require 'sightstone/modules/summoner_module'

class Sightstone
  attr_accessor :region, :api_key
  attr_accessor :summoner, :champion
  
  def initialize(api_key, region)
    @api_key = api_key
    @region = region
    
    @summoner = SummonerModule.new(self)
    @champion = ChampionModule.new(self)
  end
end

# Error classes
class SightstoneApiException < Exception; end

class SummonerNotFoundException < SightstoneApiException; end

class SightstoneConnectionException < SightstoneApiException; end

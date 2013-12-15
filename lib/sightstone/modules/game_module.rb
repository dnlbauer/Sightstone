require 'sightstone/modules/sightstone_base_module'
require 'sightstone/summoner'
require 'sightstone/match_history'

class GameModule < SightstoneBaseModule
  
  def initialize(sightstone)
    @sightstone = sightstone
  end
  
  def recent(summoner, optional={})
    region = optional[:region] || @sightstone.region
   id = if summoner.is_a? Summoner
     summoner.id
   else
     summoner
   end
   uri = "https://prod.api.pvp.net/api/lol/#{region}/v1.1/game/by-summoner/#{id}/recent"
   
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return MatchHistory.new(data)
    }
  end
  
  
end
require 'sightstone/modules/sightstone_base_module'
require 'sightstone/summoner'
require 'sightstone/match_history'

class GameModule < SightstoneBaseModule
  
  def initialize(sightstone)
    @sightstone = sightstone
  end
  
  def recent(summoner)
   id = if summoner.is_a? Summoner
     summoner.id
   else
     summoner
   end
   uri = "http://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/game/by-summoner/#{id}/recent"
   
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return MatchHistory.new(data)
    }
  end
  
  
end
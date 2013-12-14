require 'sightstone/modules/sightstone_base_module'
require 'sightstone/summoner'
require 'sightstone/league'

class LeagueModule < SightstoneBaseModule
  def initialize(sightstone)
    @sightstone = sightstone
  end
  
  def league(summoner)
    id = if summoner.is_a? Summoner
      summoner.id
    else
      summoner
    end
    
    uri = "http://prod.api.pvp.net/api/#{@sightstone.region}/v2.1/league/by-summoner/#{id}"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      leagueKeys = data.keys
      leagues = []
      leagueKeys.each do |key|
        leagues << League.new(data[key])
      end
      return leagues
    }
  end
  
end
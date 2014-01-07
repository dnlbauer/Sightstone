require 'sightstone/modules/sightstone_base_module'
require 'sightstone/summoner'
require 'sightstone/team'

module Sightstone
# module to make calls to the team api
class TeamModule < SightstoneBaseModule
  def initialize(sightstone)
    @sightstone = sightstone
  end

  # call to receive all teams for a summoner
  # @param [Summoner, Fixnum] summoner summoner object or id of a summoner
  # @param optional [Hash] optional arguments: :region => replaces default region
  # @ return [Array<Team>] An array containing all teams of the given summoner
  def teams(summoner, optional={})
    region = optional[:region] || @sightstone.region
    id = if summoner.is_a? Summoner
      summoner.id
    else
      summoner
    end
    
    uri = "https://prod.api.pvp.net/api/lol/#{region}/v2.2/team/by-summoner/#{id}"

    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      teams = []
      data.each do |team|
        teams << Team.new(team)
      end
      if block_given?
        yield teams
      else
        return teams
      end
    }
  end

end
end

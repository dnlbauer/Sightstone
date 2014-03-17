require 'sightstone/modules/sightstone_base_module'
require 'sightstone/summoner'
require 'sightstone/league'

module Sightstone
# module to provide calls to the league api
class LeagueModule < SightstoneBaseModule
  def initialize(sightstone)
    @sightstone = sightstone
  end
  
  # Provides league information of a summoner
  # @param [Summoner, Integer] summoner
  # @param optional [Hash] optional arguments: :region => replaces default region
  # @return [Array<League>] an array of all leagues the summoner and his teams are in
  def leagues(summoner, optional={})
    region = optional[:region] || @sightstone.region
    id = if summoner.is_a? Summoner
      summoner.id
    else
      summoner
    end
    
    uri = "https://prod.api.pvp.net/api/lol/#{region}/v2.3/league/by-summoner/#{id}"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      leagues = []
      data.each do |league|
        leagues << League.new(league)
      end
      if block_given?
        yield leagues
      else
        return leagues
      end
    }
  end

  # Get all entries for the given summoner
  # @param [Summoner, Integer] summoner or summoner id
  # @param optional [Hash] optional arguments: :region => replaces default region
  # @return [Array<LeagueItem>] an array of all entries for that given summoner
  def league_entries(summoner, optional={})
    region = optional[:region] || @sightstone.region
    id = if summoner.is_a? Summoner
      summoner.id
    else
      summoner
    end
    
    uri = "https://prod.api.pvp.net/api/lol/#{region}/v2.3/league/by-summoner/#{id}/entry"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      entries = []
      data.each do |entry|
        entries << LeagueItem.new(entry)
      end
      if block_given?
        yield entries
      else
        return entries
      end
    }
  end
  
end
end
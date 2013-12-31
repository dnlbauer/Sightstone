require 'sightstone/modules/sightstone_base_module'
require 'sightstone/summoner'
require 'sightstone/player_stats_summary'
require 'sightstone/ranked_stats'

# Module to receive stats
class StatsModule < SightstoneBaseModule
  def initialize(sightstone)
    @sightstone = sightstone
  end

  # get a summary of stats for a summoner
  # @param [Summoner, Fixnum] summoner summoner object of name
  # @param optional [Hash] optional arguments: :region => replaces default region
  # @ return [PlayerStatsSummaryList] of the summoner
  def summary(summoner, optional={})
    region = optional[:region] || @sightstone.region
    season = optional[:season]
    
    id = if summoner.is_a? Summoner
    summoner.id
    else
    summoner
    end
    uri = "https://prod.api.pvp.net/api/lol/#{region}/v1.2/stats/by-summoner/#{id}/summary"
    response = if season.nil?
      _get_api_response(uri)
    else
       _get_api_response(uri, {'season' => season})
    end

    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return PlayerStatsSummaryList.new(data)
    }

  end
  
  # get a summary of stats for a summoner
  # @param [Summoner, Fixnum] summoner summoner object of name
  # @param optional [Hash] optional arguments: :region => replaces default region
  # @ return [RankedStats] of the summoner
  def ranked(summoner, optional={})
    region = optional[:region] || @sightstone.region
    season = optional[:season]
    id = if summoner.is_a? Summoner
    summoner.id
    else
    summoner
    end
    uri = "https://prod.api.pvp.net/api/lol/#{region}/v1.2/stats/by-summoner/#{id}/ranked"
    response = if season.nil?
      _get_api_response(uri)
    else
       _get_api_response(uri, {'season' => season})
    end

    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return RankedStats.new(data)
    }

  end
end
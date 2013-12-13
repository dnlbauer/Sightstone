require 'sightstone/summoner'
require 'sightstone/player_stats_summary'
require 'sightstone/ranked_stats'

class StatsModule
  def initialize(sightstone)
    @sightstone = sightstone
  end

  def summary(summoner, season=nil)
    id = if summoner.is_a? Summoner
    summoner.id
    else
    summoner
    end
    uri = "https://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/stats/by-summoner/#{id}/summary"
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
  
  def ranked(summoner, season=nil)
    id = if summoner.is_a? Summoner
    summoner.id
    else
    summoner
    end
    uri = "https://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/stats/by-summoner/#{id}/ranked"
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

  def _get_api_response(uri, header={})
    params = {'api_key' => @sightstone.api_key}.merge header
    RestClient.get(uri, headers={:params => params}) {|response, request, result| response }
  rescue SocketError => e
    nil

    end

  def _parse_response(response, &block)
    response_code = if response.nil?
    500
    else
    response.code
    end

    if response_code == 200
    block.call(response.body)
    elsif response_code == 404
      raise Sightstone::SummonerNotFoundException
    elsif response_code == 500
      raise Sightstone::SightstoneConnectionException
    end
  end

end
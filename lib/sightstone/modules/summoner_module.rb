require 'sightstone/summoner'
require 'sightstone/masterybook'
require 'sightstone/runebook'

class SummonerModule
  def initialize(sightstone)
    @sightstone = sightstone
  end

  def summoner(name_or_id)
    uri = if name_or_id.is_a? Integer
      "http://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/summoner/#{name_or_id}"
    else
      "http://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/summoner/by-name/#{name_or_id}"
    end
    
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return Summoner.new(data)
    }
  end


  def names(ids)
    ids = ids.join(',')
    uri = "http://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/summoner/#{ids}/name"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return data['summoners']
    }
  end

  def runes(summoner)
    id = if summoner.is_a? Summoner
      summoner.id
    else
      summoner
    end
    uri = "http://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/summoner/#{id}/runes"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return RuneBook.new(data)
    }
  end

  def masteries(summoner)
     id = if summoner.is_a? Summoner
      summoner.id
    else
      summoner
    end
    uri = "http://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/summoner/#{id}/masteries"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return MasteryBook.new(data)
    }
  end

  private

  def _get_api_response(uri)
    params = {'api_key' => @sightstone.api_key}
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

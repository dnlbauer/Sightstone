require 'rest_client'
require 'JSON'
Dir["sightstone/*.rb"].each {|file| require file }
Dir["sightstone/modules*.rb"].each {|file| require file }


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

class SummonerModule
  
  def initialize(sightstone)
    @sightstone = sightstone
  end
  
  def get_summoner_by_name(name)
    uri = "http://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/summoner/by-name/#{name}"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return Summoner.new(data)
    }
  end

  def get_summoner_by_id(id)
    uri = "http://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/summoner/#{id}"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return Summoner.new(data)
    }
  end

  def get_summoners_names(ids)
    ids = ids.join(',')
    uri = "http://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/summoner/#{ids}/name"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return data['summoners']
    }
  end

  def get_runes_for_summoner(summoner)
    uri = "http://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/summoner/#{summoner.id}/runes"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return RuneBook.new(data)
    }
  end

  def get_masteries_for_summoner(summoner)
    uri = "http://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/summoner/#{summoner.id}/masteries"
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

class ChampionModule
  def initialize(sightstone)
    @sightstone = sightstone
  end
  
  def get_champions(free_to_play=false)
    uri = "https://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/champion"
    response = _get_api_response(uri, {'freeToPlay' => free_to_play})
      
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      champions = []
      data['champions'].each do |champ|
        champions << Champion.new(champ)
      end
      return champions
    }
  end
  
  def _get_api_response(uri, headers={})
    params = {'api_key' => @sightstone.api_key}.merge headers
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
    elsif response_code == 500
      raise Sightstone::SightstoneConnectionException
    end
  end
end
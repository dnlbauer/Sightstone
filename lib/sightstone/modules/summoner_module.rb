require 'sightstone/modules/sightstone_base_module'
require 'sightstone/summoner'
require 'sightstone/masterybook'
require 'sightstone/runebook'
require 'open-uri'

class SummonerModule < SightstoneBaseModule
  def initialize(sightstone)
    @sightstone = sightstone
  end

  def summoner(name_or_id, optional={})
    region = optional[:region] || @sightstone.region
    uri = if name_or_id.is_a? Integer
      "https://prod.api.pvp.net/api/lol/#{region}/v1.1/summoner/#{name_or_id}"
    else
      "https://prod.api.pvp.net/api/lol/#{region}/v1.1/summoner/by-name/#{URI::encode(name_or_id)}"
    end
    
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return Summoner.new(data)
    }
  end


  def names(ids, optional={})
    region = optional[:region] || @sightstone.region
    ids = ids.join(',')
    uri = "http://prod.api.pvp.net/api/lol/#{region}/v1.1/summoner/#{ids}/name"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return data['summoners']
    }
  end

  def runes(summoner, optional={})
    region = optional[:region] || @sightstone.region
    id = if summoner.is_a? Summoner
      summoner.id
    else
      summoner
    end
    uri = "http://prod.api.pvp.net/api/lol/#{region}/v1.1/summoner/#{id}/runes"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return RuneBook.new(data)
    }
  end

  def masteries(summoner, optional={})
    region = optional[:region] || @sightstone.region
     id = if summoner.is_a? Summoner
      summoner.id
    else
      summoner
    end
    uri = "http://prod.api.pvp.net/api/lol/#{region}/v1.1/summoner/#{id}/masteries"
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return MasteryBook.new(data)
    }
  end
end

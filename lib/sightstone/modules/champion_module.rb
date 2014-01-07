require 'sightstone/champion'
require 'sightstone/modules/sightstone_base_module'
module Sightstone
# Module to provide calls to the summoner api
class ChampionModule < SightstoneBaseModule

  def initialize(sightstone)
    @sightstone = sightstone
  end

  # call to get champions
  # @param optional [Hash] optional arguments: :region => replaces default region, :free_to_play => boolean (only free to play champs if true)
  # @return [Array<Champion>] array of champs
  def champions(optional={})
    region = optional[:region] || @sightstone.region
    free_to_play = optional[:free_to_play]
    uri = "https://prod.api.pvp.net/api/lol/#{region}/v1.1/champion"
    response = _get_api_response(uri, {'freeToPlay' => free_to_play})

    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      champions = []
      data['champions'].each do |champ|
        champions << Champion.new(champ)
      end
      if block_given?
        yield champions
      else
        return champions
      end
    }
  end
end
end
require 'sightstone/champion'
require 'sightstone/modules/sightstone_base_module'

class ChampionModule < SightstoneBaseModule

  def initialize(sightstone)
    @sightstone = sightstone
  end

  def champions(free_to_play=false)
    uri = "https://prod.api.pvp.net/api/lol/#{@sightstone.region}/v1.1/champion"
    response = _get_api_response(uri, {'freeToPlay' => free_to_play})
  puts response

    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      champions = []
      data['champions'].each do |champ|
        champions << Champion.new(champ)
      end
      return champions
    }
  end
end
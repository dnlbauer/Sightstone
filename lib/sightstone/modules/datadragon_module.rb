require 'sightstone/modules/sightstone_base_module'

class DatadragonModule < SightstoneBaseModule

  def initialize(sightstone)
    @sightstone = sightstone
  end

  def version(optional={})
    region = optional[:region] || @sightstone.region
    uri = "http://ddragon.leagueoflegends.com/realms/#{region}.json"
   
    response = _get_api_response(uri)
    _parse_response(response) { |resp|
      data = JSON.parse(resp)
      return data['v']
    }
  end
  
  
end

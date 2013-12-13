require 'sightstone/champion'

class ChampionModule

  def initialize(sightstone)
    @sightstone = sightstone
  end

  def get_champions(free_to_play=false)
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
  
  private
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
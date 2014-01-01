require 'open-uri'

# Base class of the api modules
# @abstract
class SightstoneBaseModule
  
  protected
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
    elsif response_code == 429
      raise Sightstone::RateLimitExceededException
    elsif response_code == 401
	raise Sightstone::InvalidApiKeyException
    else
      raise Sightstone::SightstoneApiException 'Unknown error occured'
    end
  end
  
end

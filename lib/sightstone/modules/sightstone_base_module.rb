require 'open-uri'
module Sightstone
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
      raise SummonerNotFoundException
    elsif response_code == 500
      raise SightstoneConnectionException
    elsif response_code == 429
      raise RateLimitExceededException
    elsif response_code == 401
	    raise InvalidApiKeyException
    else
      raise SightstoneApiException
    end
  end
  
end

end
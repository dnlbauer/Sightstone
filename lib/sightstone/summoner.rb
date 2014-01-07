module Sightstone
# Class to represent a summoner
# @attr [String] name name
# @attr [Long] id summoner id (used for other calls)
# @attr [Integer] profileIconId profile icon id of the summoner
# @attr [long] revisionDate timestamp of latest data change
# @attr [Integer] level summoner level
class Summoner
  
  attr_accessor :name, :id, :profileIconId, :revisionDate, :level
  
  # @param data [Hash] json hash representation of the summoner
  def initialize(data)
     @name = data['name']
     @id =  data['id']
     @profileIconId =  data['profileIconId']
     @revisionDate =  data['revisionDate']
     @level =  data['summonerLevel']
  end
  
  
end
end
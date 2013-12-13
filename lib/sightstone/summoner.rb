

class Summoner
  
  attr_accessor :name, :id, :profileIconId, :revisionDate, :level
  
  def initialize(data)
     @name = data['name']
     @id =  data['id']
     @profileIconId =  data['profileIconId']
     @revisionDate =  data['revisionDate']
     @level =  data['summonerLevel']
  end
  
  
end
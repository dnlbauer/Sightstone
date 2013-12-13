

class Summoner
  
  attr_accessor :name, :id, :profile_icon_id, :revision_date, :level
  
  def initialize(data)
     @name = data['name']
     @id =  data['id']
     @profile_icon_id =  data['profileIconId']
     @revision_date =  data['revisionDate']
     @level =  data['summonerLevel']
  end
  
  
end
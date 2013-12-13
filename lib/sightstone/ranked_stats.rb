require 'sightstone/stat'

class RankedStats
  attr_accessor :champions, :modifyData, :modifyDateStr, :summonerId
  
  def initialize(data)
    @summonerId = data['summonerId']
    @modifyDate = data['modifyDate']
    @modifyDateStr = data['modifyDateStr']
    @champions = []
    
    data['champions'].each do |champ|
      @champions << ChampionStats.new(champ)
    end
  end
end

class ChampionStats
  attr_accessor :id, :name, :stats
  
  def initialize(data)
    @id = data['id']
    @name =  data['name']
    @stats = []
    
    data['stats'].each do |stat|
      @stats << ChampionStat.new(stat)
    end
  end
end

class ChampionStat < Stat
  
  attr_accessor :count
  
  def initialize(data)
    super(data)
    @count = data['c']
  end
end
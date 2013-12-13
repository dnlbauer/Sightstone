class League
  attr_accessor :entries, :name, :queue, :tier, :timestamp
  
  def initialize(data)
    @name = data['name']
    @queue = data['queue']
    @tier = data['tier']
    @timestamp = data['timestamp']
    @entries = []
    data['entries'].each do |entry|
      @entries << LeagueItem.new(entry)
    end  
  end
end

class LeagueItem
  attr_accessor :isFreshBlood, :isHotStreak, :isActive, :isVeteran, :lastPlayed, :leagueName, :leaguePoints, :losses, :miniSeries, :playerOrTeamId, :playerOrTeamName, :queueType, :rank, :tier, :timeUntilDecay, :wins
 
  def initialize(data)
    @isFreshBlood=data['isFreshBlood']
    @isHotStreak=data['isHotStreak']
    @isActive=data['isActive']
    @isVeteran=data['isVeteran']
    @lastPlayed=data['lastPlayed']
    @leagueName=data['leageuName']
    @leaguePoints=data['leaguePoints']
    @losses=data['losses']
    @miniSeries= MiniSeries.new(data['miniSeries']) if data.has_key? 'miniSeries'
    @playerOrTeamId=data['playerOrTeamId']
    @playerOrTeamName=data['playerOrTeamName']
    @queueType=data['queueType']
    @rank=data['rank']
    @tier=data['tier']
    @timeUntilDecay=data['timeUntilDecay']
    @wins=data['wins']
  end
end

class MiniSeries
  attr_accessor :losses, :wins, :target, :progress, :timeLeftToPlayMillis
  def initialize(data)
    @losses = data['losses']
    @wins = data['wins']
    @target = data['target']
    @progress = data['progress']
    @timeLeftToPlayMillis = data['timeLeftToPlayMillies']
  end
end

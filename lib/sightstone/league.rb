module Sightstone
# Class to represent a league
# @attr [String] name name of the league
# @attr [String] queue queue Type (can be: RANKED_SOLO_5x5, RANKED_TEAM_3x3, RANKED_TEAM_5x5)
# @attr [String] tier tier of the requestet summoner (can be: CHALLENGER, DIAMOND, PLATINUM, GOLD, SILVER, BRONZE)
# @attr [Array<LeagueItem>] entries  
class League
  attr_accessor :entries, :name, :queue, :tier, :participantId
  
  def initialize(data)
    @name = data['name']
    @queue = data['queue']
    @tier = data['tier']
    @participantId = data['participantId']
    @entries = []
    data['entries'].each do |entry|
      @entries << LeagueItem.new(entry)
    end  
  end
end

# One entry of a league
# @attr [Boolean] isFreshBlood determines if summoner is new in the league
# @attr [Boolean] isHotStreak hotStreak = 3 games won in a row
# @attr [Boolean] isInactive true if summoner is inactive
# @attr [Boolean] isVetern true if veteran
# @attr [Fixnum] lastPlayed timestamp of last played game
# @attr [String] leagueName name of the league
# @attr [Fixnum] leaguePoints leaguePoints
# @attr [MiniSeries, nil] nil if player has no miniseries, a miniseries object if he is in one
# @attr [String] playerOrTeamId id of the player or team as a string
# @attr [String] playerOrTeamName name of the player/team
# @attr [String] queueType type of the queue
# @attr [String] rank rank (can be: I, II, III, IV, V)
# @attr [String] tier tier (can be: CHALLENGER, DIAMOND, PLATINUM, GOLD, SILVER, BRONZE)
# @attr [Fixnum] wins number of won matches in given queue
class LeagueItem
  attr_accessor :isFreshBlood, :isHotStreak, :isInactive, :isVeteran, :lastPlayed, :leagueName, :leaguePoints, :miniSeries, :playerOrTeamId, :playerOrTeamName, :queueType, :rank, :tier, :wins
 
  def initialize(data)
    @isFreshBlood=data['isFreshBlood']
    @isHotStreak=data['isHotStreak']
    @isInactive=data['isInactive']
    @isVeteran=data['isVeteran']
    @lastPlayed=data['lastPlayed']
    @leagueName=data['leagueName']
    @leaguePoints=data['leaguePoints']
    @miniSeries= MiniSeries.new(data['miniSeries']) if data.has_key? 'miniSeries'
    @playerOrTeamId=data['playerOrTeamId']
    @playerOrTeamName=data['playerOrTeamName']
    @queueType=data['queueType']
    @rank=data['rank']
    @tier=data['tier']
    @wins=data['wins']
  end
end

# Class to represent a MiniSeries (Promotion games)
# @attr [Fixnum] losses number of lost games of the series
# @attr [Fixnum] wins number of won games of the series
# @attr [Fixnum] target number of required wins to win the series
# @attr [Fixnum] timeLeftToPlayMillis time left to complete the series
# @attr [String] win/loose history as a string. Each character shows a (W)in, (L)oss or (N)ot played
class MiniSeries
  attr_accessor :losses, :wins, :target, :progress, :timeLeftToPlayMillis
  def initialize(data)
    @losses = data['losses']
    @wins = data['wins']
    @target = data['target']
    @progress = data['progress']
    @timeLeftToPlayMillis = data['timeLeftToPlayMillis']
  end
end
end

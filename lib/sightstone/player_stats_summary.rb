module Sightstone
# summary of player statistic
# @attr [Fixnum] summonerId ID of the summoner
# @attr [Array<PlayerStatSummary] array of stat summaries for player with given id
class PlayerStatsSummaryList
  
  attr_accessor :summonerId, :playerStatSummaries
  
  def initialize(data)
    @summonerId = data['summonerId']
    @playerStatSummaries = []
    data['playerStatSummaries'].each do |summary|
      @playerStatSummaries << PlayerStatSummary.new(summary)
    end
  end
end

# stat sumary for a queue
# @attr [Fixnum] wins number of won game
# @attr [Fixnum] losses number of lost games
# @attr [Fixnum] modifyDate date of modification as unix date
# @attr [String] playerStatSummaryType type of the stat (can be: AramUnranked5x5, CoopVsAI, OdinUnranked, RankedPremade3x3, RankedPremade5x5, RankedSolo5x5, RankedTeam3x3, RankedTeam5x5, Unranked, Unranked3x3, OneForAll5x5, FirstBlood1x1, FirstBlood2x2)
# @attr [Hash<String, Fixnum>] aggregatedStats a hash of all stats (key) and their values.
class PlayerStatSummary
  attr_accessor :wins, :losses, :modifyDate, :playerStatSummaryType, :aggregatedStats
  
  def initialize(data)
    @wins = data['wins']
    @losses = data['losses']
    @modifyDate = data['modifyDate']
    @playerStatSummaryType = data['playerStatSummaryType']  
    @aggregatedStats = {}
    stat_keys = data['aggregatedStats'].keys
    stat_keys.each do |stat|
      @aggregatedStats[stat] = data['aggregatedStats'][stat]
    end
  end
end
end
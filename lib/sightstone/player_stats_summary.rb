require 'sightstone/stat'

class PlayerStatsSummaryList
  
  attr_accessor :summonerId, :playerStatSummaries
  
  def initialize(data)
    @summonerId = data['playerStatSummary']
    @playerStatSummaries = []
    data['playerStatSummaries'].each do |summary|
      @playerStatSummaries << PlayerStatSummary.new(summary)
    end
  end
end

class PlayerStatSummary
  attr_accessor :wins, :losses, :modifyDateStr, :modifyDate, :playerStatSummaryType, :aggregatedStats
  
  def initialize(data)
    @wins = data['wins']
    @losses = data['losses']
    @modifyDatStr = data['modifyDateStr']
    @modifyDate = data['modifyDate']
    @playerStatSummaryType = data['playerStatSummaryType']  
    @aggregatedStats = []
    data['aggregatedStats'].each do |stat|
      @aggregatedStats << Stat.new(data)
    end
  end
end
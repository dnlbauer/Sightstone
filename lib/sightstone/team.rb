class Team
  attr_accessor :teamStatSummary, :status, :tag, :roster, :lastGameDate, :modifyDate, :teamId, :timestamp, :lastJoinDate, :secondLastJoinDate, :matchHistory, :lastJoinedRankedTeamQueueDate, :name, :thirdLastJoinDate, :createDate
  def initialize(data)
    @status = data['status']
    @tag = data['tag']
    @roster = Roster.new(data['roster'])
    @lastGameDate = data['lastGameDate']
    @modifyDate = data['modifyDate']
    @teamId = data['teamId']['fullId']
    @timestamp = data['timestamp']
    @lastJoinDate = data['lastJoinDate']
    @secondLastJoinDate = data['secondLastJoinDate']
    @matchHistory = []
    data['matchHistory'].each do |game|
      matchHistory << Game.new(game)
    end
    @lastJoinedRankedTeamQueueDate=data['lastJoinedRankedTeamQueueDate']
    @name = data['name']
    @thirdLastJoinDate = data['thirdLastJoinDate']
    @createDate = data['createDate']
    @teamStatSummary = []
    data['teamStatSummary']['teamStatDetails'].each do |detail|
      teamStatSummary << TeamStat.new(detail)
    end

  end
end

class Roster
  attr_accessor :ownerId, :memberList
  def initialize(data)
    @ownerId = data['ownerId']
    @memberList = []
    data['memberList'].each do |m|
      memberList << Member.new(m)
    end
  end
end

class Member
  attr_accessor :joinDate, :inviteDate, :status, :playerId
  def initialize(data)
    @joinDate = data['joinDate']
    @inviteDate = data['inviteDate']
    @status = data['status']
    @playerId = data['playerId']
  end
end

class TeamStat
  attr_accessor :wins, :losses, :averageGamesPlayed, :teamId, :teamStatType
  def initialize(data)
    @wins = data['wins']
    @losses = data['losses']
    @averageGamesPlayed = data['averageGamesPlayed']
    @teamId = data['teamId']
    @teamStatType = data['teamStatType']

  end
end

class Game
  attr_accessor :gameMode, :mapId, :assists, :opposingTeamName, :invalid, :deaths, :gameId, :kills, :win, :date, :opposingTeamKills
  def initialize(data)
    @gameMode = data['gameMode']
    @mapId = data['mapId']
    @assists = data['assists']
    @opposingTeamName = data['opposingTeamName']
    @invalid = data['invalid']
    @deaths = data['deaths']
    @gameId = data['gameId']
    @kills = data['kills']
    @win = data['win']
    @date = data['date']
    @opposingTeamKills = data['opposingTeamKills']
  end
end
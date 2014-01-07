module Sightstone
# A Team
# @attr [Fixnum] createDate UNIX timestamp of team creation
# @attr [String] fullId id of the team
# @attr [Fixnum] lastGameDate UNIX timespamp of last game
# @attr [Fixnum] lastJoinDate UNIX timestamp of the date where the newest player joined the team
# @attr [Fixnum] lastJoinedRankedTeamQueueDate UNIX timestamp of latest team game
# @attr [Array<TeamHistoryGame>] matchHistory List of latest games
# @attr [Fixnum] modifyDate UNIX timestamp of latest team modification
# @attr [String] name team name
# @attr [Roster] roster team roster
# @attr [Fixnum] secondLastJoinDate UNIX timestamp of second latest join date of a member
# @attr [String] status team status
# @attr [String] tag tag of the team
# @attr [Array<TeamStat>] teamStatSummary array containing the stats of the team
# @attr [Fixnum] thridLastJoinDate UNIX timestamp of third latest join date of a member       
class Team
  attr_accessor :teamStatSummary, :status, :tag, :roster, :lastGameDate, :modifyDate, :teamId, :lastJoinDate, :secondLastJoinDate, :matchHistory, :lastJoinedRankedTeamQueueDate, :name, :thirdLastJoinDate, :createDate
  def initialize(data)
    @status = data['status']
    @tag = data['tag']
    @roster = Roster.new(data['roster'])
    @lastGameDate = data['lastGameDate']
    @modifyDate = data['modifyDate']
    @teamId = data['fullId']
    @lastJoinDate = data['lastJoinDate']
    @secondLastJoinDate = data['secondLastJoinDate']
    @matchHistory = []
    data['matchHistory'].each do |game|
      matchHistory << TeamHistoryGame.new(game)
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

# class to represent the roster of a team
# @attr [Fixnum] ownerId summoner ID of the team owner
# @attr [Array<Member>] memberList list of all team members
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

# member of a team
# @attr [Fixnum] joinDate UNIX timestamp of join date
# @attr [Fixnum] inviteDate UNIX timestamp of invitation date
# @attr [String] status status of the team member
# @attr [Fixnum] playerId summoner ID of the member
class Member
  attr_accessor :joinDate, :inviteDate, :status, :playerId
  def initialize(data)
    @joinDate = data['joinDate']
    @inviteDate = data['inviteDate']
    @status = data['status']
    @playerId = data['playerId']
  end
end

# statistical overview of a team
# @attr [Fixnum] wins number of won games
# @attr [Fixnum] losses number of lost games
# @attr [Fixnum] averageFamesPlayed average played games of member
# @attr [String] fullId id of the team
# @attr [String] teamStatType queue of the stat
class TeamStat 
  attr_accessor :wins, :losses, :averageGamesPlayed, :fullId, :teamStatType
  def initialize(data)
    @wins = data['wins']
    @losses = data['losses']
    @averageGamesPlayed = data['averageGamesPlayed']
    @fullId = data['fullId']
    @teamStatType = data['teamStatType']

  end
end

# Recent game of a team
# @attr [Fixnum] gameMode mode of the game
# @attr [Fixnum] mapId ID of the map
# @attr [Fixnum] assists assists of the team
# @attr [String] opposingTeamName name of the enemy team
# @attr [Boolean] invalid Invalid flag # TODO what is this?
# @attr [Fixnum] deaths number of deaths summed over all players of the team
# @attr [Boolean] win true if game has been won by the team 
# @attr [Fixnum] opposingTeamKills number of kills of the enemy team
# @attr [Fixnum] gameId ID of the game
# @attr [Fixnum] kills kills of the team
class TeamHistoryGame
  attr_accessor :gameMode, :mapId, :assists, :opposingTeamName, :invalid, :deaths, :gameId, :kills, :win, :opposingTeamKills
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
    @opposingTeamKills = data['opposingTeamKills']
  end
end
end
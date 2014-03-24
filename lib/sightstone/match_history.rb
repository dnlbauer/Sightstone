module Sightstone
# match history of a summoner
# @attr [Fixnum] summonerId ID of the summoner
# @attr [Array<HistoryGame>] games unsorted list of recently played games
class MatchHistory
  attr_accessor :games, :summonerId
  
  def initialize(data)
    @summonerId = data['summonerId']
    @games = []
    data['games'].each do |game|
      games << HistoryGame.new(game)
    end
  end
end

# A played game
# @attr [Fixnum] championId ID of the played champ of requested summoner
# @attr [Fixnum] createDate UNIX timestamp of creation date of the games
# @attr [Array<Player>] fellowPlayers a list of all players of the game
# @attr [Fixnum] gameId ID of the game
# @attr [String] gameMode mode of the game
# @attr [String] gameType type of the game
# @attr [Boolean] invalid Invalid flag #TODO what is this?
# @attr [Fixnum] level level of the requested summoner
# @attr [Fixnum] mapId ID of the played map
# @attr [Fixnum] spell1 selected summoner spell no 1
# @attr [Fixnum] spell2 selected summoner spell no 2
# @attr [String] subType subtype
# @attr [Fixnum] teamId ID of the team if there is a team associated to the game
# @attr [Hash<String, Fixnum, Boolean>] statistics statistics of the game as a Hash: name -> value
class HistoryGame
  attr_accessor :championId, :createDate, :fellowPlayers, :gameId, :gameMode, :gameType, :invalid, :level, :mapId, :spell1, :spell2, :statistics, :subType, :teamId
  
  def initialize(data)
    @championId=data['championId']
    @createDate=data['createDate']
    @createDateString=data['createDateString']
    @fellowPlayers=[]
    if(data.has_key? "fellowPlayers")
    data['fellowPlayers'].each do |player|
      @fellowPlayers << Player.new(player)
    end
  end
    @gameId=data['gameId']
    @gameMode=data['gameMode']
    @gameType=data['gameType']
    @invalid=data['invalid']
    @level=data['level']
    @mapId=data['mapId']
    @spell1=data['spell1']
    @spell2=data['spell2']
    @statistics = {}
    data['stats'].each do |key, stat|
      @statistics[key] = stat
    end
    @subType=data['subType']
    @teamId=data['teamId']
  end
end

# player of a game
# @attr [Fixnum] championId ID of played Champion
# @attr [Fixnum] summonerId ID of the summoner
# @attr [Fixnum] teamId ID of the team
class Player
  attr_accessor :championId, :summonerId, :teamId
  
  def initialize(data)
    @championId = data['championId']
    @summonerId = data['summonerId']
    @teamId = data['teamId']
  end
end

end

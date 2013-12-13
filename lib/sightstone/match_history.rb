require 'sightstone/stat'

class MatchHistory
  attr_accessor :games, :summonerId
  
  def initialize(data)
    @summonerId = data['summonerId']
    @games = []
    data['games'].each do |game|
      games << Game.new(game)
    end
  end
end

class Game
  attr_accessor :championId, :createDate, :createDateString, :fellowPlayers, :gameId, :gameMode, :gameType, :invalid, :level, :mapId, :spell1, :spell2, :statistics, :subType, :teamId
  
  def initialize(data)
    @championId=data['championId']
    @createDate=data['createDate']
    @createDateString=data['createDateString']
    @fellowPlayers=[]
    data['fellowPlayers'].each do |player|
      @fellowPlayers << Player.new(player)
    end
    @gameId=data['gameId']
    @gameMode=data['gameMode']
    @gameType=data['gameType']
    @invalid=data['invalid']
    @level=data['level']
    @mapId=data['mapId']
    @spell1=data['spell1]']
    @spell2=data['spell2']
    @statistics = []
    data['statistics'].each do |stat|
      @statistics << Stat.new(stat)
    end
    @subType=data['subType']
    @teamId=data['teamId']
  end
end

class Player
  attr_accessor :championId, :summonerId, :teamId
  
  def initialize(data)
    @championId = data['championId']
    @summonerId = data['summonerId']
    @teamId = data['teamId']
  end
end
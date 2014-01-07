require 'test/unit'
require 'sightstone'



class GameModuleTest < BaseTest
  
  def test_recent_games
    begin
      matchHistory = @@sightstone.game.recent(@@req_id)
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    assert_instance_of(Sightstone::MatchHistory, matchHistory)
    assert_instance_of(Fixnum, matchHistory.summonerId)
    assert_instance_of(Array, matchHistory.games)
    matchHistory.games.each do |game|
      _check_game game
    end
  end
  
  def _check_game(game)
    assert_instance_of(Sightstone::HistoryGame, game)
    assert_instance_of(Fixnum, game.createDate)
    assert_instance_of(Fixnum, game.championId)
    assert_instance_of(Fixnum, game.gameId)
    assert_instance_of(String, game.gameType)
    assert(game.invalid || !game.invalid)
    assert_instance_of(Fixnum, game.level)
    assert_instance_of(Fixnum, game.mapId)
    assert_instance_of(Fixnum, game.spell1)
    assert_instance_of(Fixnum, game.spell2)
    assert_instance_of(String, game.subType)
    assert_instance_of(Fixnum, game.teamId)
    assert_instance_of(Array, game.fellowPlayers)
    assert_instance_of(Array, game.statistics)
    _check_statistics(game.statistics)
    _check_fellows(game.fellowPlayers)
  end
  
  def _check_statistics(stats)
   stats.each do |stat|
     assert_instance_of(Sightstone::Stat, stat)
     assert_instance_of(Fixnum, stat.value)
     assert_instance_of(Fixnum, stat.id)
     assert_instance_of(String, stat.name)
   end
  end
  
  def _check_fellows(fellows)
    fellows.each do |fellow|
      assert_instance_of(Sightstone::Player, fellow)
      assert_instance_of(Fixnum, fellow.championId)
      assert_instance_of(Fixnum, fellow.summonerId)
      assert_instance_of(Fixnum, fellow.teamId)
    end
  end
  
  
end
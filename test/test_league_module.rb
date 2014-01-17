require 'test/unit'
require 'sightstone'



class LeagueModuleTest < BaseTest
  
  def test_league
    begin
      leagues = @@sightstone.league.leagues(@@req_id)
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    leagues.each do |league|
      assert_instance_of(Sightstone::League, league)
      
      # check the league entries
      _check_league(league)
    end
  end
  
  def _check_league(league)
    assert_instance_of String, league.name
    assert_instance_of String, league.queue
    assert_instance_of String, league.tier
    assert_instance_of Array, league.entries
    league.entries.each do |entry|
      _check_league_item entry
    end
  end
  
  def _check_league_item(item)
    assert_instance_of Sightstone::LeagueItem, item
    assert (item.isFreshBlood == true or item.isFreshBlood == false), "#{item.isFreshBlood} should be a boolean"
    assert (item.isHotStreak == true or item.isHotStreak == false), "#{item.isHotStreak} should be a boolean"
    assert (item.isInactive == true or item.isInactive == false), "#{item.isInactive} should be a boolean"
    assert (item.isVeteran == true or item.isVeteran == false), "#{item.isVeteran} should be a boolean"
    assert_instance_of Fixnum, item.lastPlayed
    assert_instance_of String, item.leagueName
    assert_instance_of Fixnum, item.leaguePoints
    assert_instance_of String, item.playerOrTeamId
    assert_instance_of String, item.playerOrTeamName
    assert_instance_of String, item.queueType
    assert_instance_of String, item.rank
    assert_instance_of String, item.tier
    assert_instance_of Fixnum, item.wins
    
    _check_miniseries(item.miniSeries) unless item.miniSeries.nil?
  end
  
  def _check_miniseries(ms)
    assert_instance_of Sightstone::MiniSeries, ms
    assert_instance_of Fixnum, ms.losses
    assert_instance_of Fixnum, ms.wins
    assert_instance_of Fixnum, ms.target
    assert_instance_of Fixnum, ms.timeLeftToPlayMillis
    assert_instance_of String, ms.progress
  end
  
end
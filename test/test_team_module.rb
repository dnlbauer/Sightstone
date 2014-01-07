require 'test/unit'
require 'sightstone'

class TeamModuleTest < BaseTest
  
  def test_teams
    begin
      teams = @@sightstone.team.teams @@req_id
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    assert_instance_of(Array, teams)
    teams.each do |team|
      _check_team(team)
    end
  end
  
  def _check_team(team)
    assert_instance_of(Sightstone::Team, team)
    assert_instance_of(String, team.status)
    assert_instance_of(String, team.tag)
    assert_instance_of(Sightstone::Roster, team.roster)
    _check_roster(team.roster)
    assert_instance_of(Fixnum, team.lastGameDate)
    assert_instance_of(Fixnum, team.modifyDate)
    assert_instance_of(String, team.teamId)
    assert_instance_of(Fixnum, team.lastJoinDate)
    assert_instance_of(Fixnum, team.secondLastJoinDate)
    assert_instance_of(Array, team.matchHistory)
    _check_history(team.matchHistory)
    assert_instance_of(Fixnum, team.lastJoinedRankedTeamQueueDate)
    assert_instance_of(String, team.name)
    assert_instance_of(Fixnum, team.thirdLastJoinDate)
    assert_instance_of(Fixnum, team.createDate)
    assert_instance_of(Array, team.teamStatSummary)
    _check_team_stats(team.teamStatSummary)
  end
  
  def _check_roster(roster)
    assert_instance_of(Fixnum, roster.ownerId)
    assert_instance_of(Array, roster.memberList)
    roster.memberList.each do |member|
      assert_instance_of(Sightstone::Member, member)
      assert_instance_of(Fixnum, member.joinDate)
      assert_instance_of(Fixnum, member.inviteDate)
      assert_instance_of(Fixnum, member.playerId)
      assert_instance_of(String, member.status)
    end
  end
  
  def _check_history(history)
    history.each do |game|
      assert_instance_of(Sightstone::TeamHistoryGame, game)
      assert_instance_of(String, game.gameMode)
      assert_instance_of Fixnum, game.mapId
      assert_instance_of Fixnum, game.assists
      assert_instance_of String, game.opposingTeamName
      assert (game.invalid || !game.invalid), "game.invalid should be a boolean"
      assert_instance_of Fixnum, game.deaths
      assert_instance_of Fixnum, game.gameId
      assert_instance_of Fixnum, game.kills
      assert (game.win || !game.win), "game.win should be a boolean"
      assert_instance_of Fixnum, game.opposingTeamKills
    end
  end
  
  def _check_team_stats(stats)
    stats.each do |stat|
      assert_instance_of(Sightstone::TeamStat, stat)
      assert_instance_of(Fixnum, stat.wins)
      assert_instance_of(Fixnum, stat.losses)
      assert_instance_of(Fixnum, stat.averageGamesPlayed)
      assert_instance_of(String, stat.fullId)
      assert_instance_of(String, stat.teamStatType)
    end
  end
  
end
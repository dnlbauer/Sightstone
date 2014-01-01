require 'test/unit'
require 'sightstone'

class StatsModuleTest < BaseTest
  
  def test_summary
    begin
      summary = @@sightstone.stats.summary @@req_id
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    assert_instance_of(PlayerStatsSummaryList, summary)
    assert_instance_of(Fixnum, summary.summonerId)
    assert_instance_of(Array, summary.playerStatSummaries)
    summary.playerStatSummaries.each do |summary|
      _check_summary(summary)
    end
  end
  
  def _check_summary(sum)
    assert_instance_of(PlayerStatSummary, sum)
    assert_instance_of(Fixnum, sum.wins)
    assert_instance_of(Fixnum, sum.losses)
    assert_instance_of(Fixnum, sum.modifyDate)
    assert_instance_of(String, sum.playerStatSummaryType)
    assert_instance_of(Hash, sum.aggregatedStats)
    keys = sum.aggregatedStats.keys
    keys.each do |key|
      assert_instance_of(Fixnum, sum.aggregatedStats[key])
    end
  end
  
  def test_ranked_stats
    begin
      stats = @@sightstone.stats.ranked @@req_id
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    assert_instance_of(Fixnum, stats.summonerId)
    assert_instance_of(Fixnum, stats.modifyDate)
    assert_instance_of(Hash, stats.champions)
    keys = stats.champions.keys
    keys.each do |champId|
      assert_instance_of(Hash, stats.champions[champId])
      statkeys = stats.champions[champId].keys
      statkeys.each do |statkey|
        assert_instance_of(String, statkey)
        assert_instance_of(Fixnum, stats.champions[champId][statkey])
      end
    end
  end

  
end
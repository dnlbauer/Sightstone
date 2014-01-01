require 'test/unit'
require 'sightstone'



class ChampionModuleTest < BaseTest
  
  def test_champions
    begin
      champions = @@sightstone.champion.champions
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    assert_instance_of(Array, champions)
    if(champions.size > 0)
      _check_champion(champions[0])
    end
  end
  
  def test_free_to_play
    begin
      champions = @@sightstone.champion.champions :free_to_play => true
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    champions.each do |champ|
      assert_equal(true, champ.freeToPlay)
    end
  end
  
  def _check_champion(champ)
    assert_instance_of(Champion, champ)
    assert_instance_of(Fixnum, champ.attackRank)
    assert_instance_of(Fixnum, champ.defenseRank)
    assert_instance_of(String, champ.name)
    assert_instance_of(Fixnum, champ.id)
  end

end
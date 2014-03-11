require 'test/unit'
require 'sightstone'



class SummonerModuleTest < BaseTest
    
  def _check_summoner_validity(s)
    assert_instance_of(String, s.name)
    assert_instance_of(Fixnum, s.id)
    assert_instance_of(Fixnum, s.profileIconId)
    assert_instance_of(Fixnum, s.revisionDate)
    assert_instance_of(Fixnum, s.level)
  end
  
  def test_multiple_summoners_by_names
   begin
     s = @@sightstone.summoner.summoners([@@test_name, @@test_name2])
     s.each do |name, summoner|
        _check_summoner_validity(summoner)
        assert_equal name.downcase, summoner.name.downcase
     end
   rescue Sightstone::RateLimitExceededException
     puts "Rate limit exeeded, waiting 1 sec"
     sleep 1
     retry
   end
    
  end

  def test_summoner_by_name
    begin
     s = @@sightstone.summoner.summoner(@@test_name)
   rescue Sightstone::RateLimitExceededException
     puts "Rate limit exeeded, waiting 1 sec"
     sleep 1
     retry
   end
     _check_summoner_validity(s)

  end
  
  def test_summoner_by_id
    begin
      s = @@sightstone.summoner.summoner(@@test_id_array[0])
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    _check_summoner_validity(s)
  end
    
  def test_summoner_names
    begin
      names = @@sightstone.summoner.names(@@test_id_array)
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    assert_instance_of(Hash, names)
    @@test_id_array.each do |id|
      assert_equal(names.has_key?(id), true)
      assert_instance_of(String, names[id])
    end
  end  
  
  def test_summoner_runebook
    begin
      runebook = @@sightstone.summoner.runebook(@@test_id_array[0])
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    assert_equal(@@test_id_array[0], runebook.summonerId)
    assert_instance_of(Array, runebook.pages)
    if runebook.pages.size > 0
      # test a page
      page = runebook.pages[0]
      if(page.current == true || page.current == false)
        assert_equal(true, true)
      else
        assert_equal(page.current, "asd")
      end
      assert_instance_of(Fixnum, page.id)
      assert_instance_of(String, page.name)
      assert_instance_of(Hash, page.slots)
      
      if(page.slots.keys.size > 0)
        # test rune
        rune = page.slots[page.slots.keys[0]]
        assert_instance_of(String, rune.description)
        assert_instance_of(String, rune.name)
        assert_instance_of(Fixnum, rune.tier)
        assert_instance_of(Fixnum, rune.id)
      end
    end
  end

  def test_summoner_runebooks
    begin
      runebooks = @@sightstone.summoner.runebooks(@@test_id_array)
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    runebooks.each do |key, runebook|
    assert_equal(@@test_id_array[0], runebook.summonerId)
    assert_instance_of(Array, runebook.pages)
    if runebook.pages.size > 0
      # test a page
      page = runebook.pages[0]
      if(page.current == true || page.current == false)
        assert_equal(true, true)
      else
        assert_equal(page.current, "asd")
      end
      assert_instance_of(Fixnum, page.id)
      assert_instance_of(String, page.name)
      assert_instance_of(Hash, page.slots)
      
      if(page.slots.keys.size > 0)
        # test rune
        rune = page.slots[page.slots.keys[0]]
        assert_instance_of(String, rune.description)
        assert_instance_of(String, rune.name)
        assert_instance_of(Fixnum, rune.tier)
        assert_instance_of(Fixnum, rune.id)
      end
    end
    end
  end
  
  def test_summoner_masterybook
    begin
      masterybook = @@sightstone.summoner.masterybook(@@test_id_array[0])
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    assert_equal(@@test_id_array[0], masterybook.summonerId)
    assert_instance_of(Array, masterybook.pages)
    if masterybook.pages.size > 0
      # test a page
      page = masterybook.pages[0]
      if(page.current == true || page.current == false)
        assert_equal(true, true)
      else
        assert_equal(page.current, "asd")
      end
      assert_instance_of(Fixnum, page.id)
      assert_instance_of(String, page.name)
      assert_instance_of(Array, page.talents)
      
      if(page.talents.size > 0)
        # test talent
        talent = page.talents[0]
        assert_instance_of(Fixnum, talent.rank)
        assert_instance_of(String, talent.name)
        assert_instance_of(Fixnum, talent.id)
      end
    end
  end

  def test_summoner_masterybooks
    begin
      masterybooks = @@sightstone.summoner.masterybooks(@@test_id_array)
    rescue Sightstone::RateLimitExceededException
      puts "Rate limit exeeded, waiting 1 sec"
      sleep 1
      retry
    end
    masterybooks.each do |id, masterybook|
      assert_equal(@@test_id_array[0], masterybook.summonerId)
    assert_instance_of(Array, masterybook.pages)
    if masterybook.pages.size > 0
      # test a page
      page = masterybook.pages[0]
      if(page.current == true || page.current == false)
        assert_equal(true, true)
      else
        assert_equal(page.current, "asd")
      end
      assert_instance_of(Fixnum, page.id)
      assert_instance_of(String, page.name)
      assert_instance_of(Array, page.talents)
      
      if(page.talents.size > 0)
        # test talent
        talent = page.talents[0]
        assert_instance_of(Fixnum, talent.rank)
        assert_instance_of(String, talent.name)
        assert_instance_of(Fixnum, talent.id)
      end
    end
    end
  end
  

end
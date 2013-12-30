require 'test/unit'
require 'sightstone'



class SummonerModuleTest < BaseTest
  
  @@test_name = "danijoo"
  @@test_id_array = [30447079,30447079,30447079]
  
  def _check_summoner_validity(s)
    assert_instance_of(String, s.name)
    assert_instance_of(Fixnum, s.id)
    assert_instance_of(Fixnum, s.profileIconId)
    assert_instance_of(Fixnum, s.revisionDate)
    assert_instance_of(Fixnum, s.level)
  end
  
  def test_summoner_by_name
     s = @@sightstone.summoner.summoner(@@test_name)
     _check_summoner_validity(s)
  end
  
  def test_summoner_by_id
    s = @@sightstone.summoner.summoner(@@test_id_array[0])
    _check_summoner_validity(s)
  end
    
  def test_summoner_names
    names = @@sightstone.summoner.names(@@test_id_array)
    assert_instance_of(Hash, names)
    @@test_id_array.each do |id|
      assert_equal(names.has_key?(id), true)
      assert_instance_of(String, names[id])
    end
  end  
  
  def test_summoner_runebook
    runebook = @@sightstone.summoner.runes(@@test_id_array[0])
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
  
  def test_summoner_masterybook
    masterybook = @@sightstone.summoner.masteries(@@test_id_array[0])
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
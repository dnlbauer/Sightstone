require 'test/unit'
require 'sightstone'

class BaseTest < Test::Unit::TestCase
  
  @@sightstone = Sightstone::Sightstone.new("your_api_key_here")

  @@req_id = 30447079
  @@test_id_array = [30447079,30447079,30447079]
  @@test_name = "danijoo"
  @@test_name2 = "pippu"
  
end

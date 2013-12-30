require 'test/unit'
require 'sightstone'

class BaseTest < Test::Unit::TestCase
  
  @@sightstone = Sightstone.new("your_api_key_here")
  
end

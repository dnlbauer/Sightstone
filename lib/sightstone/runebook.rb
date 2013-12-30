# Class to represent the runebook of a summoner
# @attr [Numeric] summonerId id of the summoner
# @attr [Array<RunePage>] pages of the runebook
class RuneBook
  attr_accessor :pages, :summonerId
  
  def initialize(data)
    @summonerId = data['summonerId']
    @pages = []
    data['pages'].each do |page|
      @pages << RunePage.new(page)
    end
  end
end

# Class to represent a page of a runebook
# @attr [Numeric] id ID of the page
# @attr [String] name page name
# @attr [Boolean] current indicates if the page is selected
# @attr [Hash<Numeric, Rune>] slots matches slot ids to the rune  
class RunePage
  attr_accessor :id, :slots, :name, :current
  
  def initialize(data)
    @id = data['id']
    @name = data['name']
    @current = data['current']
    @slots = {}
    data['slots'].each do |slot|
      @slots[slot['runeSlotId']] = Rune.new(slot['rune'])
    end
  end

end

# Class to represent a rune
# @attr [Numeric] id ID of the rune
# @attr [String] description description
# @attr [String] name name of the rune
# @attr [Numeric] tier rune tier (1,2,3)
class Rune
  attr_accessor :id, :description, :name, :tier
  
  def initialize(data)
    @id = data['id']
    @description = data['description']
    @name = data['name']
    @tier = data['tier']
  end
end
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

class Rune
  attr_accessor :id, :description, :name, :tier
  
  def initialize(data)
    @id = data['id']
    @description = data['description']
    @name = data['name']
    @tier = data['tier']
  end
end
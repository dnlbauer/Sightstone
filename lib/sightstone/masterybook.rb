class MasteryBook
  attr_accessor :pages, :summonerId
  
  def initialize(data)
    @summonerId = data['summonerId']
    @pages = []
    data['pages'].each do |page|
      @pages << MasteryPage.new(page)
    end
  end
end

class MasteryPage
  attr_accessor :id, :talents, :name, :current
  
  def initialize(data)
    @id = data['id']
    @name = data['name']
    @current = data['current']
    @talents = []
    data['talents'].each do |talent|
      @talents << Talent.new(talent)
    end
  end

end

class Talent
  attr_accessor :id,:rank, :name
  
  def initialize(data)
    @id = data['id']
    @name = data['name']
    @rank = data['rank']
  end
end
module Sightstone
# Class to represent the masterybook of a summoner
# @attr [Numeric] summonerId id of the summoner
# @attr [Array<MasteryPage>] pages of the masterybook
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

# Class to represent a page of a masterybook
# @attr [Numeric] id ID of the page
# @attr [String] name page name
# @attr [Boolean] current indicates if the page is selected
# @attr [Array<Talent>] array of selected talents
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

# Class to represent a talent of a mastery page
# @attr [Numeric] id id of the mastery
# @attr [String] name of the mastery
# @attr [Numeric] rank rank of the mastery
class Talent
  attr_accessor :id,:rank, :name
  
  def initialize(data)
    @id = data['id']
    @name = data['name']
    @rank = data['rank']
  end
end
end
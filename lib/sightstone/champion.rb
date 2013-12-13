class Champion
  attr_accessor :active, :attackRank, :botEnabled, :botMmEnabled
  attr_accessor :defenseRank, :difficultyRank, :freeToPlay, :id, :magicRank, :name, :rankedPlayEnabled
  
  def initialize(data)
    @active = data['active']
    @attackRank = data['attackRank']
    @botEnabled = data['botEnabled']
    @defenseRank = data['defenseRank']
    @difficultyRank = data['difficultyRank']
    @freeToPlay = data['freeToPlay']
    @id = data['id']
    @magicRank = data['magicRank']
    @name = data['name']
    @rankedPlayEnabled = data['rankedPlayEnabled']
  end
  
end
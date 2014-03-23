module Sightstone
# Class to represent a champion
# @attr [Boolean] active determines if champion is active
# @attr [Integer] attackRank attack rank
# @attr [Boolean] botEnabled Bot enabled flag (for custom games)
# @attr [Boolean] botMmEnabled Bot Match Made enabeld flag (for Coop/AI games)
# @attr [Integer] defenseRank	Champion defense rank.
# @attr [Integer] difficultyRank Champion difficulty rank.
# @attr [Boolean] freeToPlay Indicates if the champion is free to play. Free to play champions are rotated periodically.
# @attr [Fixnum] id	Champion ID.
# @attr [Integer] magicRank	Champion magic rank.
# @attr [String] name Champion name.
# @attr [boolean] rankedPlayEnabled	Ranked play enabled flag.
class Champion
  attr_accessor :active, :attackRank, :botEnabled, :botMmEnabled
  attr_accessor :defenseRank, :difficultyRank, :freeToPlay, :id, :magicRank, :name, :rankedPlayEnabled
  
  def initialize args
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
  
end
end
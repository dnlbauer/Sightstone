require 'sightstone/stat'
# Ranked stats of a summoner
# @attr [Fixnum] modifyDate date of last modification
# @attr [Fixnum] summonerId id of the summoner
# @attr [Hash<Fixnum, Hash<String, Fixnum>>] champions Statisitc for each champion in a Hash. Each key stands for a champions id (0 is sum of all champs) and returns a Hash<stat, stat_value>.
class RankedStats
  attr_accessor :champions, :modifyDate, :summonerId
  
  def initialize(data)
    @summonerId = data['summonerId']
    @modifyDate = data['modifyDate']
    @champions = {}
    
    data['champions'].each do |champ|
      id = champ['id']
      @champions[id] = Hash.new unless @champions.has_key? id
      stat_keys = champ['stats'].keys
      stat_keys.each do |key|
        @champions[id][key] = champ['stats'][key]
      end
    end
  end
end

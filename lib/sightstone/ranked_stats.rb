module Sightstone
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
    @names = {}
    
    data['champions'].each do |champ|
      id = champ['id']
      if(!@champions.has_key?(id))
        @champions[id] = Hash.new
        @names[champ['name']] = id
      end 

      stat_keys = champ['stats'].keys
      stat_keys.each do |key|
        @champions[id][key] = champ['stats'][key]
      end
    end

    # returns the statistics of a champion by its normailized name
    # @param name [String] normalized name or Combined
    # @return [Hash<String, Fixnum>] A Hash mapping statistic names to their values
    def get_statistics_by_name(name)
      if(@names.has_key? name)
        @champions[@names[name]]
      end
    end
  end
end
end

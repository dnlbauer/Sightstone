require 'spec_helper'
require 'json'

module Sightstone
describe League do

	before :all do
		json_mockup = JSON.parse('{"queue": "RANKED_SOLO_5x5","name": "Vladimirs Maulers","participantId": "5908","entries": 
			[{"isHotStreak": false,"isFreshBlood": false,"leagueName": "Vladimirs Maulers","isVeteran": true,"tier": "DIAMOND","lastPlayed": -1,
				"playerOrTeamId": "27280077","leaguePoints": 0,"rank": "V","isInactive": false,"queueType": "RANKED_SOLO_5x5","playerOrTeamName": "TLP fierce1","wins": 210},
				{"isHotStreak": false,"isFreshBlood": false,"leagueName": "Vladimirs Maulers","isVeteran": true,"tier": "DIAMOND","lastPlayed": -1,"playerOrTeamId": "19571444","leaguePoints": 84,
					"rank": "IV","isInactive": false,"queueType": "RANKED_SOLO_5x5","playerOrTeamName": "KINGSTON PLEASE","wins": 111},{"isHotStreak": false,"isFreshBlood": false,
						"leagueName": "Vladimirs Maulers","isVeteran": false,"tier": "DIAMOND","lastPlayed": -1,"playerOrTeamId": "77988","leaguePoints": 42,
						"rank": "V","isInactive": false,"queueType": "RANKED_SOLO_5x5","playerOrTeamName": "Pluripotential","wins": 69},{"isHotStreak": false,
							"isFreshBlood": false,"leagueName": "Vladimirs Maulers","isVeteran": false,"tier": "DIAMOND","lastPlayed": -1,"playerOrTeamId": "24717856",
							"leaguePoints": 22,"rank": "IV","isInactive": false,"queueType": "RANKED_SOLO_5x5","playerOrTeamName": "Red X Hero","wins": 66},
							{"isHotStreak": false,"isFreshBlood": false,"leagueName": "Vladimirs Maulers","isVeteran": true,"tier": "DIAMOND","lastPlayed": -1,
								"playerOrTeamId": "477045","leaguePoints": 68,"rank": "III","isInactive": false,"queueType": "RANKED_SOLO_5x5",
								"playerOrTeamName": "SmashGizmo","wins": 130},{"isHotStreak": true,"isFreshBlood": false,"leagueName": "Vladimirs Maulers",
									"isVeteran": true,"tier": "DIAMOND","lastPlayed": -1,"playerOrTeamId": "21466580","leaguePoints": 69,"rank": "IV",
									"isInactive": false,"queueType": "RANKED_SOLO_5x5","playerOrTeamName": "TLP TerminaTop","wins": 103},
									{"isHotStreak": false,"isFreshBlood": false,"leagueName": "Vladimirs Maulers","isVeteran": false,
										"tier": "DIAMOND","lastPlayed": -1,"playerOrTeamId": "19033574","leaguePoints": 0,"rank": "V",
										"isInactive": false,"queueType": "RANKED_SOLO_5x5","playerOrTeamName": "NeiLy","wins": 155},
										{"isHotStreak": false,"isFreshBlood": false,"leagueName": "Vladimirs Maulers",
											"isVeteran": false,"tier": "DIAMOND","lastPlayed": -1,"playerOrTeamId": "30753436","leaguePoints": 26,"rank": "III","isInactive": false,
											"queueType": "RANKED_SOLO_5x5","playerOrTeamName": "HellFire114N","wins": 39},{"isHotStreak": false,"isFreshBlood": false,"leagueName": "Vladimirs Maulers",
												"isVeteran": true,"tier": "DIAMOND","lastPlayed": -1,"playerOrTeamId": "19322489","leaguePoints": 27,"rank": "I","isInactive": false,
												"queueType": "RANKED_SOLO_5x5","playerOrTeamName": "EyeMtheStron9est","wins": 86},{"isHotStreak": false,"isFreshBlood": false,
													"leagueName": "Vladimirs Maulers","isVeteran": true,"tier": "DIAMOND","lastPlayed": -1,"playerOrTeamId": "21020883",
													"leaguePoints": 28,"rank": "I","isInactive": false,"queueType": "RANKED_SOLO_5x5","playerOrTeamName": "Bobo the Builder","wins": 75}],
													"tier": "DIAMOND"}')
		@league = League.new(json_mockup)
	end

	describe "#new" do
		it "should initialize a league object" do
			@league.should be_an_instance_of League
		end

		it "should initialize with correct params" do
			@league.name.should be_a_kind_of String
			@league.queue.should be_a_kind_of String
			@league.tier.should be_a_kind_of String
			@league.entries.should be_an_instance_of Array
		end
	end

	describe "#entries" do
		it "should return a list of league entries" do
			@league.entries.each {|e| e.should be_an_instance_of LeagueItem}
		end
	end

end


describe LeagueItem do
	before :all do
		json_mockup = JSON.parse('{"isHotStreak": true,"isFreshBlood": false,"leagueName": "Vladimirs Maulers","miniSeries": {"progress": "WNN","target": 2,"losses": 0,"timeLeftToPlayMillis": -1,"wins": 1},"isVeteran": false,"tier": "DIAMOND","lastPlayed": -1,"playerOrTeamId": "19046003","leaguePoints": 100,"rank": "IV","isInactive": false,"queueType": "RANKED_SOLO_5x5","playerOrTeamName": "Taishi Masamune","wins": 55}')
		@le = LeagueItem.new(json_mockup)
	end

	describe "#new" do
		it "should initialize a LeagueItem" do
			@le.should be_an_instance_of LeagueItem
		end

		it "should initiliaze with correct params" do
			@le.isHotStreak.should satisfy {|s| [true, false].include? s}
			@le.isFreshBlood.should satisfy {|s| [true, false].include? s}
			@le.isVeteran.should satisfy {|s| [true, false].include? s}
			@le.isInactive.should satisfy {|s| [true, false].include? s}
			@le.leagueName.should be_a_kind_of String
			@le.tier.should be_a_kind_of String
			@le.lastPlayed.should be_a_kind_of Fixnum
			@le.playerOrTeamId.should be_a_kind_of String
			@le.leaguePoints.should be_a_kind_of Fixnum
			@le.rank.should be_a_kind_of String
			@le.queueType.should be_a_kind_of String
			@le.playerOrTeamName.should be_a_kind_of String
			@le.wins.should be_a_kind_of Fixnum
			@le.miniSeries.should be_an_instance_of MiniSeries
		end
	end
end

describe MiniSeries do
	before :all do
		json_mockup = JSON.parse('{"progress": "WNN","target": 2,"losses": 0,"timeLeftToPlayMillis": -1,"wins": 1}')
		@ms = MiniSeries.new(json_mockup)
	end

	describe "#new" do
		it "should initilaize a miniSeries object" do
			@ms.should be_an_instance_of MiniSeries
		end

		it "should initialize with correct params" do
			@ms.progress.should be_a_kind_of String
			@ms.target.should be_a_kind_of Fixnum
			@ms.losses.should be_a_kind_of Fixnum
			@ms.wins.should be_a_kind_of Fixnum
			@ms.timeLeftToPlayMillis.should be_a_kind_of Fixnum
		end
	end
end
end
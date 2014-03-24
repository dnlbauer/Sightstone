require 'spec_helper'
require 'json'

module Sightstone
	describe RankedStats do

		before :all do
			response_mockup = JSON.parse('{"modifyDate": 1395302832000,"champions": [{"id": 32,"stats": {"totalDeathsPerSession": 9,"totalSessionsPlayed": 2,"totalDamageTaken": 61928,"totalQuadraKills": 0,
				"totalTripleKills": 0,"totalMinionKills": 123,"maxChampionsKilled": 5,"totalDoubleKills": 0,"totalPhysicalDamageDealt": 46675,"totalChampionKills": 6,"totalAssists": 14,
				"mostChampionKillsPerSession": 5,"totalDamageDealt": 321647,"totalFirstBlood": 0,"totalSessionsLost": 2,"totalSessionsWon": 0,"totalMagicDamageDealt": 235049,
				"totalGoldEarned": 20974,"totalPentaKills": 0,"totalTurretsKilled": 0,"mostSpellsCast": 0,"maxNumDeaths": 6,"totalUnrealKills": 0},"name": "Amumu"},
				{"id": 1,"stats": {"totalDeathsPerSession": 62,"totalSessionsPlayed": 10,"totalDamageTaken": 143058,"totalQuadraKills": 0,"totalTripleKills": 0,
					"totalMinionKills": 482,"maxChampionsKilled": 6,"totalDoubleKills": 1,"totalPhysicalDamageDealt": 59834,"totalChampionKills": 23,"totalAssists": 88,
					"mostChampionKillsPerSession": 6,"totalDamageDealt": 432245,"totalFirstBlood": 0,"totalSessionsLost": 7,"totalSessionsWon": 3,"totalMagicDamageDealt": 370212,
					"totalGoldEarned": 84267,"totalPentaKills": 0,"totalTurretsKilled": 3,"mostSpellsCast": 0,"maxNumDeaths": 11,"totalUnrealKills": 0},"name": "Annie"},
					{"id": 0,"stats": {"totalDamageTaken": 3097057,"totalTripleKills": 8,"totalMinionKills": 10853,"maxChampionsKilled": 17,
					"maxLargestCriticalStrike": 1121,"totalChampionKills": 690,"totalPhysicalDamageDealt": 6284046,
					"rankedPremadeGamesPlayed": 0,"totalSessionsLost": 68,"totalNeutralMinionsKilled": 4342,
						"totalSessionsWon": 63,"totalMagicDamageDealt": 6696776,"maxLargestKillingSpree": 8,"totalPentaKills": 0,
						"maxTimeSpentLiving": 1731,"totalDeathsPerSession": 701,"totalQuadraKills": 1,"totalSessionsPlayed": 131,
						"totalDoubleKills": 49,"totalAssists": 1157,"maxTimePlayed": 3158,"mostChampionKillsPerSession": 17,
						"totalDamageDealt": 13820857,"botGamesPlayed": 0,"killingSpree": 320,"totalFirstBlood": 0,"rankedSoloGamesPlayed": 0,
						"totalHeal": 800579,"totalGoldEarned": 1423092,"mostSpellsCast": 0,"totalTurretsKilled": 99,"maxNumDeaths": 11,
						"totalUnrealKills": 0,"normalGamesPlayed": 0},"name": "Combined"}],"summonerId": 12345}')
			@rs = RankedStats.new(response_mockup)
		end

		describe "#new" do
			it "should create a ranked stats obejct" do
				@rs.should be_an_instance_of RankedStats
			end	

			it "should have a modification date" do
				@rs.modifyDate.should be_a_kind_of Fixnum
			end

			it "should have a summoner id" do
				@rs.summonerId.should be_a_kind_of Fixnum
			end
		end

		describe "#champions" do
			it "should have combined statsitics" do
				@rs.champions[0].should be_an_instance_of Hash
			end

			it "should have some champion dependent statistic" do
				@rs.champions.should be_a_kind_of Hash
				@rs.champions.should have_at_least(1).items
				@rs.champions[32].should be_a_kind_of Hash
			end
		end

		describe "#get_statistics_by_name" do
			it "should return combined stats for attr 'Combined'" do
				@rs.get_statistics_by_name('Combined').should eql @rs.champions[0]
			end

			it "should return champions statistics for champion name" do
				@rs.get_statistics_by_name("Annie").should eql @rs.champions[1]
			end

			it "should return nil if champion name is not in the stats" do
				@rs.get_statistics_by_name("asdf").should be_nil
			end
		end

	end

end

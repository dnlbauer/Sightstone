require 'spec_helper'
require 'json'

module Sightstone

	describe MatchHistory do

		before :all do
			json_mockup = JSON.parse('{"games":[{"gameType": "MATCHED_GAME","fellowPlayers": [{"championId": 102,"teamId": 100,"summonerId": 19440603},{"championId": 51,"teamId": 200,"summonerId": 26261198},{"championId": 79,"teamId": 100,"summonerId": 22151489},{"championId": 13,"teamId": 200,"summonerId": 23429462},{"championId": 106,"teamId": 200,"summonerId": 30818765},{"championId": 48,"teamId": 200,"summonerId": 25932666},{"championId": 24,"teamId": 100,"summonerId": 22906613},{"championId": 89,"teamId": 200,"summonerId": 33288326},{"championId": 16,"teamId": 100,"summonerId": 238666}],"stats": {"totalDamageDealtToChampions": 26806,"item2": 3252,"goldEarned": 12738,"item1": 3031,"wardPlaced": 9,"totalDamageTaken": 25573,"item0": 1055,"trueDamageDealtPlayer": 10713,"physicalDamageDealtPlayer": 129104,"trueDamageDealtToChampions": 5597,"killingSprees": 2,"totalUnitsHealed": 1,"largestCriticalStrike": 696,"level": 16,"doubleKills": 1,"neutralMinionsKilledYourJungle": 8,"neutralMinionsKilledEnemyJungle": 7,"assists": 5,"magicDamageTaken": 9216,"numDeaths": 9,"totalTimeCrowdControlDealt": 604,"largestMultiKill": 2,"physicalDamageTaken": 15714,"sightWardsBought": 2,"win": false,"team": 100,"totalDamageDealt": 139818,"largestKillingSpree": 4,"totalHeal": 1004,"item4": 3072,"item3": 3046,"item6": 3340,"minionsKilled": 171,"timePlayed": 2124,"physicalDamageDealtToChampions": 21208,"championsKilled": 10,"trueDamageTaken": 642,"goldSpent": 14620,"neutralMinionsKilled": 15},"gameId": 1390514911,"spell1": 4,"teamId": 100,"spell2": 21,"gameMode": "CLASSIC","mapId": 1,"level": 30,"invalid": false,"subType": "RANKED_SOLO_5x5","championId": 29,"createDate": 1395672014277}], "summonerId": 12345}')
			@mh = MatchHistory.new(json_mockup)
		end

		describe "#new" do

			it "should init a match hisotry object" do
				@mh.should be_instance_of MatchHistory
			end

			it "should init with correct params" do
				@mh.summonerId.should be_instance_of Fixnum
				@mh.games.should be_instance_of Array
				@mh.games.each do |game|
					game.should be_instance_of HistoryGame
				end
			end
		end
	end

	describe HistoryGame do
		before :all do
			json_mockup = JSON.parse('{"gameType": "MATCHED_GAME","fellowPlayers": [{"championId": 102,"teamId": 100,"summonerId": 19440603},{"championId": 51,"teamId": 200,"summonerId": 26261198},{"championId": 79,"teamId": 100,"summonerId": 22151489},{"championId": 13,"teamId": 200,"summonerId": 23429462},{"championId": 106,"teamId": 200,"summonerId": 30818765},{"championId": 48,"teamId": 200,"summonerId": 25932666},{"championId": 24,"teamId": 100,"summonerId": 22906613},{"championId": 89,"teamId": 200,"summonerId": 33288326},{"championId": 16,"teamId": 100,"summonerId": 238666}],"stats": {"totalDamageDealtToChampions": 26806,"item2": 3252,"goldEarned": 12738,"item1": 3031,"wardPlaced": 9,"totalDamageTaken": 25573,"item0": 1055,"trueDamageDealtPlayer": 10713,"physicalDamageDealtPlayer": 129104,"trueDamageDealtToChampions": 5597,"killingSprees": 2,"totalUnitsHealed": 1,"largestCriticalStrike": 696,"level": 16,"doubleKills": 1,"neutralMinionsKilledYourJungle": 8,"neutralMinionsKilledEnemyJungle": 7,"assists": 5,"magicDamageTaken": 9216,"numDeaths": 9,"totalTimeCrowdControlDealt": 604,"largestMultiKill": 2,"physicalDamageTaken": 15714,"sightWardsBought": 2,"win": false,"team": 100,"totalDamageDealt": 139818,"largestKillingSpree": 4,"totalHeal": 1004,"item4": 3072,"item3": 3046,"item6": 3340,"minionsKilled": 171,"timePlayed": 2124,"physicalDamageDealtToChampions": 21208,"championsKilled": 10,"trueDamageTaken": 642,"goldSpent": 14620,"neutralMinionsKilled": 15},"gameId": 1390514911,"spell1": 4,"teamId": 100,"spell2": 21,"gameMode": "CLASSIC","mapId": 1,"level": 30,"invalid": false,"subType": "RANKED_SOLO_5x5","championId": 29,"createDate": 1395672014277}')
			@hg = HistoryGame.new(json_mockup)
		end

		describe "#new" do
			it "should init a history game" do
				@hg.should be_instance_of HistoryGame
			end

			it "should init with correct params" do
				@hg.championId.should be_instance_of Fixnum
				@hg.createDate.should be_instance_of Fixnum
				@hg.fellowPlayers.should be_instance_of Array
				@hg.fellowPlayers.each do |p|
					p.should be_instance_of Player
				end
				@hg.gameId.should be_instance_of Fixnum
				@hg.gameMode.should be_instance_of String
				@hg.gameType.should be_instance_of String
				@hg.invalid.should satisfy {|s| [true, false].include? s}
				@hg.level.should be_instance_of Fixnum
				@hg.mapId.should be_instance_of Fixnum
				@hg.spell1.should be_instance_of Fixnum
				@hg.spell2.should be_instance_of Fixnum
				@hg.statistics.should be_instance_of Hash
				@hg.statistics.each do |key, stat|
					key.should be_instance_of String
					stat.should satisfy {|s| ([true, false].include?(s) or s.is_a?(Fixnum))}
				end
				@hg.subType.should be_instance_of String
				@hg.teamId.should be_instance_of Fixnum
			end
		end
	end

	describe Player do
		before :all do
			mockup_json = JSON.parse('{"championId": 79,"teamId": 100,"summonerId": 22151489}')
			@player = Player.new(mockup_json)
		end

		describe "#new" do

			it "should init a player" do
				@player.should be_instance_of Player
			end

			it "should init with correct params" do
				@player.championId.should be_instance_of Fixnum
				@player.summonerId.should be_instance_of Fixnum
				@player.teamId.should be_instance_of Fixnum
			end

		end
	end


end
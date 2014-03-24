require 'spec_helper'
require 'json'

module Sightstone

	describe PlayerStatsSummaryList do

		before :all do
			json_mockup = JSON.parse('{"playerStatSummaries": [{"playerStatSummaryType": "Unranked3x3","aggregatedStats": {"totalNeutralMinionsKilled": 1854,"totalMinionKills": 4256,"totalChampionKills": 280,"totalAssists": 333,"totalTurretsKilled": 30},"modifyDate": 1395243794000,"wins": 31}], "summonerId": 30447079}')
			@pssl = PlayerStatsSummaryList.new(json_mockup)
		end

		describe "#new" do
			it "should init player stat summary list object" do
				@pssl.should be_instance_of PlayerStatsSummaryList
			end

			it "should init with correct params" do
				@pssl.summonerId.should be_instance_of Fixnum
				@pssl.playerStatSummaries.should be_instance_of Array
				@pssl.playerStatSummaries.each do |stat|
					stat.should be_instance_of PlayerStatSummary
				end
			end
		end
	end

	describe PlayerStatSummary do
		before @all do
			json_mockup = JSON.parse('{"playerStatSummaryType": "Unranked3x3","aggregatedStats": {"totalNeutralMinionsKilled": 1854,"totalMinionKills": 4256,"totalChampionKills": 280,"totalAssists": 333,"totalTurretsKilled": 30},"modifyDate": 1395243794000,"wins": 31}')
			@pss = PlayerStatSummary.new(json_mockup)
		end

		describe "#new" do
			it "should init player stat summary object" do
				@pss.should be_instance_of PlayerStatSummary
			end

			it "should init with correct params" do
				@pss.losses.should satisfy { |l| l.nil? or l.is_a?(Fixnum)}
				@pss.wins.should be_instance_of Fixnum
				@pss.modifyDate.should be_instance_of Fixnum
				@pss.playerStatSummaryType.should be_instance_of String
				@pss.aggregatedStats.should be_instance_of Hash
				@pss.aggregatedStats.each do |key, stat|
					key.should be_instance_of String
					stat.should be_instance_of Fixnum
				end
			end
		end
	end

end
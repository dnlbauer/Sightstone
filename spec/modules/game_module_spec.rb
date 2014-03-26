require 'spec_helper'

module Sightstone

	describe GameModule do

		before :each do
			@module = GameModule.new(Sightstone.new("api_key", "euw"))
			
		end

		describe "#new" do
			it "should initialize a GameModule" do
				@module.should be_instance_of GameModule
			end

		end

		describe "#recent" do

			before :each do
				raw_response = File.new("spec/modules/raw_responses/game_v1.3_euw.response")
				stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.3/game/by-summoner/summoner_id/recent?api_key=api_key").
         			with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
         			to_return(raw_response)
			end

			it "should return a list of recent games for the default region" do
				
				history = @module.recent("summoner_id")
				history.should be_instance_of MatchHistory
			end

			it "should return a recent games for given region" do
				@module.instance_variable_set("@sightstone", Sightstone.new("api_key", "na"))

				history = @module.recent("summoner_id", {region: "euw"})
				history.should be_instance_of MatchHistory
			end

			it "should evaluate codeblocks" do
				games = []
				@module.recent("summoner_id") do |history|
					games = history.games
				end
				games.each do |game|
					game.should be_instance_of HistoryGame
				end

			end

		end

	end

end
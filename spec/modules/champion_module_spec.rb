require 'spec_helper'

module Sightstone

	describe ChampionModule do

		before :each do
			@module = ChampionModule.new(Sightstone.new("api_key", "euw"))
			
		end

		describe "#new" do
			it "should initialize a ChampionModule" do
				@module.should be_instance_of ChampionModule
			end

		end

		describe "#champions" do

			before :each do
				raw_response = File.new("spec/modules/raw_responses/champion_v1.1_euw.response")
				stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.1/champion?api_key=api_key&freeToPlay=false").
         			with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
         			to_return(raw_response)

         		raw_response_f2p = File.new("spec/modules/raw_responses/champion_v1.1_euw_f2p.response")
         		stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.1/champion?api_key=api_key&freeToPlay=true").
         			with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
         			to_return(raw_response_f2p)
			end

			it "should return a list of champions for the default region" do
				
				champions = @module.champions
				champions.should be_instance_of Array
				champions.each do |champ|
					champ.should be_instance_of Champion
				end
			end

			it "should return a list of champions for given region" do
				@module.instance_variable_set("@sightstone", Sightstone.new("api_key", "na"))

				champions = @module.champions(region: "euw")
				champions.should be_instance_of Array
				champions.each do |champ|
					champ.should be_instance_of Champion
				end
			end

			it "should only return free to play champions" do
				champions = @module.champions({free_to_play: true})
				champions.should be_instance_of Array
				champions.each do |champ|
					champ.should be_instance_of Champion
					champ.freeToPlay.should be true
				end
			end

			it "should evaluate codeblocks" do
				filtered = []
				@module.champions do |champions|
					champions.each do |champ|
						filtered << champ if champ.name == "Heimerdinger"
					end
				end
				filtered.should have(1).item
				filtered[0].name.should eql "Heimerdinger"

			end

		end

	end

end
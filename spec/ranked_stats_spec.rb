require 'spec_helper'

module Sightstone
	describe RankedStats do

		before :each do
			stats = [{"id" => 1, "stats"=> {"Stat1" => 1, "Stat2" => 2}}, {"id" => 2, "stats"=> {"Stat1" => 1, "Stat2" => 2}}]
			@rs = RankedStats.new({"summonerId" => 1, "modifyDate" => 1, "champions" => stats })
		end

		it "should have a summoner id" do
			@rs.summonerId.should eql 1
		end

		it "should have a modification date" do
			@rs.modifyDate.should eql 1
		end

		it "should have an array of champion stats" do
			@rs.champions.should be_an_instance_of Hash
			@rs.champions.should have(2).items
			@rs.champions.each do |key, hash|
				key.should be_a_kind_of Fixnum
				hash.should be_an_instance_of Hash
				hash.each do |stat, value|
					stat.should be_an_instance_of String
					value.should be_a_kind_of Fixnum
				end	
			end
		end

		describe "#new" do
			it "should create a ranked stats obejct" do
				@rs.should be_an_instance_of RankedStats
			end	
		end

	end

end

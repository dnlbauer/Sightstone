require 'spec_helper'
require 'json'

module Sightstone
	describe Champion do

		before :all do
			response_mockup = JSON.parse('{"botMmEnabled": false,"defenseRank": 4,"attackRank": 8,"id": 266,
      								"rankedPlayEnabled": true,"name": "Aatrox","botEnabled": false,"difficultyRank": 6,
      								"active": true,"freeToPlay": false,"magicRank": 3}')
			@c = Champion.new(response_mockup)
		end

		describe "#new" do
			it "should initialize a champion object" do
				@c.should be_an_instance_of Champion
			end

			it "should initialize all attributes correctly" do
				@c.botMmEnabled.should satisfy {|s| [true, false].include? s}
				@c.rankedPlayEnabled.should satisfy {|s| [true, false].include? s}
				@c.botEnabled.should satisfy {|s| [true, false].include? s}
				@c.active.should satisfy {|s| [true, false].include? s}
				@c.freeToPlay.should satisfy {|s| [true, false].include? s}
				@c.defenseRank.should be_a_kind_of Fixnum
				@c.difficultyRank.should be_a_kind_of Fixnum
				@c.magicRank.should be_a_kind_of Fixnum
				@c.attackRank.should be_a_kind_of Fixnum
				@c.id.should be_a_kind_of Fixnum
				@c.name.should be_a_kind_of String
			end
		end
	end
end
require 'spec_helper'

module Sightstone
	describe Champion do
		describe "#new" do
			it "should initialize a champion object" do
				c = Champion.new({active: true, attackRank: 1, botEnabled: true, botMmEnabled: true, defenseRank: 1,
					freeToPlay: false, id: 1, magicRank: 1, name: "testName", rankedPlayEnabled: true})
				c.should be_an_instance_of Champion
			end
		end
	end
end
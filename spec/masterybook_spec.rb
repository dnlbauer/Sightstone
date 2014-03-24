require 'spec_helper'
require 'json'

module Sightstone

	describe MasteryBook do

		before :all do
			json_mockup = JSON.parse('{"pages": [{"id": 34106888,"talents": [{"id": 4211,"rank": 2,"name": "Block"},{"id": 4353,"rank": 3,"name": "Intelligence"},{"id": 4362,"rank": 1,"name": "Wanderer"},{"id": 4213,"rank": 2,"name": "Enchanted Armor"},{"id": 4322,"rank": 3,"name": "Summoners Insight"},{"id": 4334,"rank": 1,"name": "Culinary Master"},{"id": 4344,"rank": 2,"name": "Inspiration"},{"id": 4352,"rank": 1,"name": "Bandit"},{"id": 4222,"rank": 3,"name": "Veterans Scars"},{"id": 4314,"rank": 1,"name": "Scout"},{"id": 4221,"rank": 1,"name": "Unyielding"},{"id": 4331,"rank": 3,"name": "Greed"},{"id": 4324,"rank": 1,"name": "Alchemist"},{"id": 4312,"rank": 3,"name": "Fleet of Foot"},{"id": 4232,"rank": 1,"name": "Juggernaut"},{"id": 4342,"rank": 1,"name": "Wealth"},{"id": 4341,"rank": 1,"name": "Scavenger"}],"name": "gammel supp","current": false},{"id": 34106889,"talents": [{"id": 4311,"rank": 1,"name": "Phasewalker"},{"id": 4353,"rank": 3,"name": "Intelligence"},{"id": 4121,"rank": 1,"name": "Expose Weakness"},{"id": 4362,"rank": 1,"name": "Wanderer"},{"id": 4312,"rank": 2,"name": "Fleet of Foot"},{"id": 4322,"rank": 3,"name": "Summoners Insight"},{"id": 4334,"rank": 1,"name": "Culinary Master"},{"id": 4344,"rank": 2,"name": "Inspiration"},{"id": 4352,"rank": 1,"name": "Bandit"},{"id": 4113,"rank": 4,"name": "Sorcery"},{"id": 4314,"rank": 1,"name": "Scout"},{"id": 4331,"rank": 3,"name": "Greed"},{"id": 4324,"rank": 1,"name": "Alchemist"},{"id": 4123,"rank": 3,"name": "Mental Force"},{"id": 4133,"rank": 1,"name": "Arcane Mastery"},{"id": 4342,"rank": 1,"name": "Wealth"},{"id": 4341,"rank": 1,"name": "Scavenger"}],"name": "pew pew ks supp","current": false},{"id": 34106890,"talents": [{"id": 4211,"rank": 2,"name": "Block"},{"id": 4213,"rank": 2,"name": "Enchanted Armor"},{"id": 4124,"rank": 1,"name": "Feast"},{"id": 4154,"rank": 1,"name": "Arcane Blade"},{"id": 4114,"rank": 1,"name": "Butcher"},{"id": 4222,"rank": 3,"name": "Veterans Scars"},{"id": 4113,"rank": 4,"name": "Sorcery"},{"id": 4221,"rank": 1,"name": "Unyielding"},{"id": 4152,"rank": 3,"name": "Devastating Strikes"},{"id": 4123,"rank": 3,"name": "Mental Force"},{"id": 4111,"rank": 1,"name": "Double-Edged Sword"},{"id": 4134,"rank": 2,"name": "Executioner"},{"id": 4133,"rank": 1,"name": "Arcane Mastery"},{"id": 4232,"rank": 1,"name": "Juggernaut"},{"id": 4143,"rank": 3,"name": "Archmage"},{"id": 4162,"rank": 1,"name": "Havoc"}],"name": "APC resi","current": false},{"id": 34106891,"talents": [{"id": 4212,"rank": 2,"name": "Recovery"},{"id": 4211,"rank": 2,"name": "Block"},{"id": 4124,"rank": 1,"name": "Feast"},{"id": 4154,"rank": 1,"name": "Arcane Blade"},{"id": 4114,"rank": 1,"name": "Butcher"},{"id": 4222,"rank": 3,"name": "Veterans Scars"},{"id": 4113,"rank": 4,"name": "Sorcery"},{"id": 4221,"rank": 1,"name": "Unyielding"},{"id": 4152,"rank": 3,"name": "Devastating Strikes"},{"id": 4123,"rank": 3,"name": "Mental Force"},{"id": 4111,"rank": 1,"name": "Double-Edged Sword"},{"id": 4134,"rank": 2,"name": "Executioner"},{"id": 4133,"rank": 1,"name": "Arcane Mastery"},{"id": 4232,"rank": 1,"name": "Juggernaut"},{"id": 4143,"rank": 3,"name": "Archmage"},{"id": 4162,"rank": 1,"name": "Havoc"}],"name": "APC std","current": false},{"id": 34106892,"talents": [{"id": 4242,"rank": 1,"name": "Swiftness"},{"id": 4212,"rank": 2,"name": "Recovery"},{"id": 4211,"rank": 2,"name": "Block"},{"id": 4214,"rank": 2,"name": "Tough Skin"},{"id": 4213,"rank": 2,"name": "Enchanted Armor"},{"id": 4124,"rank": 1,"name": "Feast"},{"id": 4251,"rank": 1,"name": "Second Wind"},{"id": 4114,"rank": 1,"name": "Butcher"},{"id": 4222,"rank": 3,"name": "Veterans Scars"},{"id": 4221,"rank": 1,"name": "Unyielding"},{"id": 4122,"rank": 3,"name": "Brute Force"},{"id": 4112,"rank": 2,"name": "Fury"},{"id": 4262,"rank": 1,"name": "Tenacious"},{"id": 4224,"rank": 1,"name": "Bladed Armor"},{"id": 4111,"rank": 1,"name": "Double-Edged Sword"},{"id": 4132,"rank": 1,"name": "Martial Mastery"},{"id": 4241,"rank": 3,"name": "Perseverance"},{"id": 4233,"rank": 1,"name": "Hardiness"},{"id": 4232,"rank": 1,"name": "Juggernaut"}],"name": "Deff AD Jungle","current": false},{"id": 34106893,"talents": [{"id": 4212,"rank": 2,"name": "Recovery"},{"id": 4242,"rank": 1,"name": "Swiftness"},{"id": 4311,"rank": 1,"name": "Phasewalker"},{"id": 4211,"rank": 2,"name": "Block"},{"id": 4214,"rank": 2,"name": "Tough Skin"},{"id": 4213,"rank": 2,"name": "Enchanted Armor"},{"id": 4322,"rank": 3,"name": "Summoners Insight"},{"id": 4332,"rank": 1,"name": "Runic Affinity"},{"id": 4251,"rank": 1,"name": "Second Wind"},{"id": 4222,"rank": 3,"name": "Veterans Scars"},{"id": 4314,"rank": 1,"name": "Scout"},{"id": 4221,"rank": 1,"name": "Unyielding"},{"id": 4262,"rank": 1,"name": "Tenacious"},{"id": 4224,"rank": 1,"name": "Bladed Armor"},{"id": 4231,"rank": 1,"name": "Oppression"},{"id": 4312,"rank": 3,"name": "Fleet of Foot"},{"id": 4241,"rank": 3,"name": "Perseverance"},{"id": 4232,"rank": 1,"name": "Juggernaut"}],"name": "tank/utility","current": false},{"id": 34106894,"talents": [{"id": 4212,"rank": 2,"name": "Recovery"},{"id": 4214,"rank": 2,"name": "Tough Skin"},{"id": 4134,"rank": 3,"name": "Executioner"},{"id": 4124,"rank": 1,"name": "Feast"},{"id": 4154,"rank": 1,"name": "Arcane Blade"},{"id": 4114,"rank": 1,"name": "Butcher"},{"id": 4113,"rank": 4,"name": "Sorcery"},{"id": 4152,"rank": 3,"name": "Devastating Strikes"},{"id": 4123,"rank": 3,"name": "Mental Force"},{"id": 4224,"rank": 1,"name": "Bladed Armor"},{"id": 4312,"rank": 3,"name": "Fleet of Foot"},{"id": 4111,"rank": 1,"name": "Double-Edged Sword"},{"id": 4133,"rank": 1,"name": "Arcane Mastery"},{"id": 4143,"rank": 3,"name": "Archmage"},{"id": 4162,"rank": 1,"name": "Havoc"}],"name": "ap jungle","current": false},{"id": 34106895,"talents": [{"id": 4211,"rank": 2,"name": "Block"},{"id": 4134,"rank": 3,"name": "Executioner"},{"id": 4322,"rank": 3,"name": "Summoners Insight"},{"id": 4124,"rank": 1,"name": "Feast"},{"id": 4114,"rank": 1,"name": "Butcher"},{"id": 4112,"rank": 4,"name": "Fury"},{"id": 4314,"rank": 1,"name": "Scout"},{"id": 4122,"rank": 3,"name": "Brute Force"},{"id": 4152,"rank": 3,"name": "Devastating Strikes"},{"id": 4312,"rank": 3,"name": "Fleet of Foot"},{"id": 4111,"rank": 1,"name": "Double-Edged Sword"},{"id": 4132,"rank": 1,"name": "Martial Mastery"},{"id": 4142,"rank": 3,"name": "Warlord"},{"id": 4162,"rank": 1,"name": "Havoc"}],"name": "adc","current": false},{"id": 34106896,"talents": [{"id": 4233,"rank": 3,"name": "Hardiness"},{"id": 4211,"rank": 2,"name": "Block"},{"id": 4243,"rank": 1,"name": "Reinforced Armor"},{"id": 4213,"rank": 2,"name": "Enchanted Armor"},{"id": 4322,"rank": 3,"name": "Summoners Insight"},{"id": 4244,"rank": 1,"name": "Evasive"},{"id": 4234,"rank": 3,"name": "Resistance"},{"id": 4222,"rank": 3,"name": "Veterans Scars"},{"id": 4314,"rank": 1,"name": "Scout"},{"id": 4221,"rank": 1,"name": "Unyielding"},{"id": 4324,"rank": 1,"name": "Alchemist"},{"id": 4252,"rank": 4,"name": "Legendary Guardian"},{"id": 4262,"rank": 1,"name": "Tenacious"},{"id": 4312,"rank": 3,"name": "Fleet of Foot"},{"id": 4232,"rank": 1,"name": "Juggernaut"}],"name": "outrageous tank supp","current": false},{"id": 34106897,"talents": [{"id": 4212,"rank": 2,"name": "Recovery"},{"id": 4214,"rank": 2,"name": "Tough Skin"},{"id": 4134,"rank": 3,"name": "Executioner"},{"id": 4222,"rank": 3,"name": "Veterans Scars"},{"id": 4113,"rank": 4,"name": "Sorcery"},{"id": 4144,"rank": 1,"name": "Dangerous Game"},{"id": 4122,"rank": 3,"name": "Brute Force"},{"id": 4152,"rank": 3,"name": "Devastating Strikes"},{"id": 4141,"rank": 1,"name": "Blade Weaving"},{"id": 4224,"rank": 1,"name": "Bladed Armor"},{"id": 4132,"rank": 1,"name": "Martial Mastery"},{"id": 4232,"rank": 1,"name": "Juggernaut"},{"id": 4162,"rank": 1,"name": "Havoc"},{"id": 4112,"rank": 3,"name": "Fury"},{"id": 4131,"rank": 1,"name": "Spell Weaving"}],"name": "noc noc?","current": true},{"id": 34106898,"talents": [{"id": 4214,"rank": 2,"name": "Tough Skin"},{"id": 4213,"rank": 2,"name": "Enchanted Armor"},{"id": 4334,"rank": 1,"name": "Culinary Master"},{"id": 4322,"rank": 3,"name": "Summoners Insight"},{"id": 4332,"rank": 1,"name": "Runic Affinity"},{"id": 4124,"rank": 1,"name": "Feast"},{"id": 4323,"rank": 1,"name": "Strength of Spirit"},{"id": 4114,"rank": 1,"name": "Butcher"},{"id": 4222,"rank": 3,"name": "Veterans Scars"},{"id": 4314,"rank": 1,"name": "Scout"},{"id": 4324,"rank": 1,"name": "Alchemist"},{"id": 4122,"rank": 3,"name": "Brute Force"},{"id": 4224,"rank": 1,"name": "Bladed Armor"},{"id": 4313,"rank": 3,"name": "Meditation"},{"id": 4111,"rank": 1,"name": "Double-Edged Sword"},{"id": 4132,"rank": 1,"name": "Martial Mastery"},{"id": 4232,"rank": 1,"name": "Juggernaut"},{"id": 4113,"rank": 3,"name": "Sorcery"}],"name": "ww jungle","current": false},{"id": 34106899,"talents": [{"id": 4211,"rank": 2,"name": "Block"},{"id": 4214,"rank": 2,"name": "Tough Skin"},{"id": 4134,"rank": 3,"name": "Executioner"},{"id": 4114,"rank": 1,"name": "Butcher"},{"id": 4222,"rank": 3,"name": "Veterans Scars"},{"id": 4221,"rank": 1,"name": "Unyielding"},{"id": 4144,"rank": 1,"name": "Dangerous Game"},{"id": 4122,"rank": 3,"name": "Brute Force"},{"id": 4152,"rank": 3,"name": "Devastating Strikes"},{"id": 4141,"rank": 1,"name": "Blade Weaving"},{"id": 4111,"rank": 1,"name": "Double-Edged Sword"},{"id": 4132,"rank": 1,"name": "Martial Mastery"},{"id": 4232,"rank": 1,"name": "Juggernaut"},{"id": 4162,"rank": 1,"name": "Havoc"},{"id": 4112,"rank": 3,"name": "Fury"},{"id": 4142,"rank": 2,"name": "Warlord"},{"id": 4131,"rank": 1,"name": "Spell Weaving"}],"name": "vi","current": false},{"id": 34106900,"current": false}],"summonerId": 30447079}')
			@book = MasteryBook.new(json_mockup)
		end

		describe "#new" do
			it "should initialize a mastery book object" do
				@book.should be_an_instance_of MasteryBook
			end

			it "should initialize with correct params" do
				@book.pages.should be_instance_of Array
				@book.pages.each do |page|
					page.should be_instance_of MasteryPage
				end
				@book.summonerId.should be_instance_of Fixnum
			end
		end

	end

	describe MasteryPage do
		before :all do
			json_mockup = JSON.parse('{"id": 34106888,"talents": [{"id": 4211,"rank": 2,"name": "Block"},{"id": 4353,"rank": 3,"name": "Intelligence"},{"id": 4362,"rank": 1,"name": "Wanderer"},{"id": 4213,"rank": 2,"name": "Enchanted Armor"},{"id": 4322,"rank": 3,"name": "Summoners Insight"},{"id": 4334,"rank": 1,"name": "Culinary Master"}],"name": "vi","current": false}')
			@page = MasteryPage.new(json_mockup)
		end

		describe "#new" do
			it "should initilalize a mastery page" do
				@page.should be_instance_of MasteryPage
			end

			it "should initilalize with correct params" do
				@page.id.should be_instance_of Fixnum
				@page.name.should be_instance_of String
				@page.talents.should be_instance_of Array
				@page.talents.each do |talent|
					talent.should be_instance_of Talent
				end
			end
		end
	end

	describe Talent do
		before :all do
			json_mockup = JSON.parse('{"id": 4142,"rank": 2,"name": "Warlord"}')
			@talent = Talent.new(json_mockup)
		end

		describe "#new" do
			it "should init a talent" do
				@talent.should be_instance_of Talent
			end

			it "should init with correct params" do
				@talent.id.should be_instance_of Fixnum
				@talent.rank.should be_instance_of Fixnum
				@talent.name.should be_instance_of String
			end
		end
	end

end
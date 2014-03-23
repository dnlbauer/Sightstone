require 'spec_helper'

module Sightstone
  describe Sightstone do

    before :each do
      @sightstone = Sightstone.new("key", "region")
    end

    describe "#new" do

      it "should initialize a sightstone object" do
        @sightstone.should be_an_instance_of Sightstone
      end

      it "should initialize with the correct params" do
        @sightstone.api_key.should eql "key"
        @sightstone.region.should eql "region"
      end

      it "should initialize all modules" do
        @sightstone.summoner.should be_an_instance_of SummonerModule
        @sightstone.champion.should be_an_instance_of ChampionModule
        @sightstone.game.should be_an_instance_of GameModule
        @sightstone.league.should be_an_instance_of LeagueModule
        @sightstone.stats.should be_an_instance_of StatsModule
        @sightstone.ddragon.should be_an_instance_of DatadragonModule
        @sightstone.team.should be_an_instance_of TeamModule
      end

      it "should initialize with a default region" do
        s = Sightstone.new "my key"
        s.region.should eql "euw"
      end
    end
  end
end

  	 
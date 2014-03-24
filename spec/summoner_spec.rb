require 'spec_helper'
require 'json'


module Sightstone

	describe Summoner do

		before :all do
			response_mockup = JSON.parse('{"id": 5908,"name": "Dyrus","profileIconId": 627,"revisionDate": 1395525467000,"summonerLevel": 30}')
			@sum = Summoner.new(response_mockup)
		end

		describe "#new" do
			it "should initialize a summoner object" do
				@sum.should be_an_instance_of Summoner
			end

			it "should initialize with correct params" do
				@sum.id.should be_a_kind_of Fixnum
				@sum.name.should be_a_kind_of String
				@sum.profileIconId.should be_a_kind_of Fixnum
				@sum.revisionDate.should be_a_kind_of Fixnum
				@sum.level.should be_a_kind_of Fixnum
			end
		end

	end

end
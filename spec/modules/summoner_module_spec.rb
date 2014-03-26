require 'spec_helper'

module Sightstone

	describe SummonerModule do

		before :each do
			@module = SummonerModule.new(Sightstone.new("api_key", "euw"))
			
		end

		describe "#new" do
			it "should initialize a SummonerModule" do
				@module.should be_instance_of SummonerModule
			end

		end

		describe "#masterybook" do

			before :each do
				 raw_response = File.new("spec/modules/raw_responses/summoner_v1.3_masterybook.response")
				 stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.3/summoner/summoner_id/masteries?api_key=api_key").
          			with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
          			to_return(raw_response)
			end

			it "should return a mastery book" do
				@module.masterybook("summoner_id").should be_instance_of MasteryBook
			end

			it "should evaluate the codeblock" do
				@module.masterybook("summoner_id") { |book|
					book.should be_instance_of MasteryBook
				}
			end
		end

		describe "#masterybooks" do
			before :each do
				 raw_response = File.new("spec/modules/raw_responses/summoner_v1.3_masterybooks.response")
				 stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.3/summoner/summonerid1,summonerid2/masteries?api_key=api_key").
          			with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
          			to_return(raw_response)
			end

			it "should return the books of 2 summoners" do
				books = @module.masterybooks(["summonerid1","summonerid2"])
				books.should be_instance_of Hash
				books.each do |key, book|
					book.should be_instance_of MasteryBook
				end
			end

			it "should evaluate the codeblock" do
				@module.masterybooks(["summonerid1", "summonerid2"]) { |books|
					books.each do |key, book|
						book.should be_instance_of MasteryBook
					end
				}
			end
		end

		describe "#names" do
			before :each do
				 raw_response = File.new("spec/modules/raw_responses/summoner_v1.3_names.response")
				 stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.3/summoner/1,2,3/name?api_key=api_key").
          			with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
          			to_return(raw_response)
			end

			it "should return a list of names" do
				@module.names([1,2,3]).should be_instance_of Hash
				@module.names([1,2,3]) { |names| 
					names.each do |id, name|
						id.should be_instance_of Fixnum
						name.should be_instance_of String
					end
				}
			end
		end

		describe "#runebook" do
			before :each do
				 raw_response = File.new("spec/modules/raw_responses/summoner_v1.3_runebook.response")
				 stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.3/summoner/summoner_id/runes?api_key=api_key").
          			with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
          			to_return(raw_response)
			end

			it "should return a rune book" do
				@module.runebook("summoner_id").should be_instance_of RuneBook
			end

			it "should evaluate the codeblock" do
				@module.runebook("summoner_id") { |book|
					book.should be_instance_of RuneBook
				}
			end
		end

		describe "#runebooks" do
			before :each do
				 raw_response = File.new("spec/modules/raw_responses/summoner_v1.3_runebooks.response")
				 stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.3/summoner/summonerid1,summonerid2/runes?api_key=api_key").
          			with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
          			to_return(raw_response)
			end

			it "should return the books of 2 summoners" do
				books = @module.runebooks(["summonerid1", "summonerid2"])
				books.should be_instance_of Hash
				books.each do |key, book|
					book.should be_instance_of RuneBook
				end
			end

			it "should evaluate the codeblock" do
				@module.runebooks(["summonerid1", "summonerid2"]) { |books|
					books.each do |key, book|
						book.should be_instance_of RuneBook
					end
				}
			end
		end

		describe "#summoner" do
			before :each do
				 raw_response = File.new("spec/modules/raw_responses/summoner_v1.3_summoner.response").read
				 stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.3/summoner/by-name/name?api_key=api_key").
          			with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
          			to_return(raw_response)
          		stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.3/summoner/1?api_key=api_key").
          			with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
          			to_return(raw_response)

			end

			it "should return a summoner by name" do
				@module.summoner("name").should be_instance_of Summoner
			end

			it "should return a summoner by id" do
				@module.summoner(1).should be_instance_of Summoner
			end
		end

		describe "#summoners" do
			before :each do
				 raw_response = File.new("spec/modules/raw_responses/summoner_v1.3_summoners.response")
				 stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.3/summoner/by-name/name1,name2?api_key=api_key").
          			with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
          			to_return(raw_response)
			end


			it "should return multiple summoners" do
				@summoners = @module.summoners(['name1', 'name2'])
				@summoners.should be_instance_of Hash
				@summoners.each do |key, value|
					key.should satisfy {|key| (key.is_a? Fixnum or key.is_a? String) }
					value.should be_instance_of Summoner
				end
			end
		end

	end

end
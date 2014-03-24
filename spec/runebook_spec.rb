require 'spec_helper'
require 'json'

module Sightstone

  describe RuneBook do

    before :all do
      json_mockup = JSON.parse('{"pages":[{"id": 27005798,"slots": [{"runeSlotId": 1,"rune": {"id": 5273,"description": "+0.87 magic penetration","name": "Greater Mark of Magic Penetration","tier": 3}},{"runeSlotId": 2,"rune": {"id": 5273,"description": "+0.87 magic penetration","name": "Greater Mark of Magic Penetration","tier": 3}},{"runeSlotId": 3,"rune": {"id": 5273,"description": "+0.87 magic penetration","name": "Greater Mark of Magic Penetration","tier": 3}}],"name": "fulltank ap","current": false}], "summonerId":12345}')
      @book = RuneBook.new(json_mockup)
    end

    describe "#new" do
      it "should initialize a rune book object" do
        @book.should be_an_instance_of RuneBook
      end

      it "should initialize with correct params" do
        @book.pages.should be_instance_of Array
        @book.pages.each do |page|
          page.should be_instance_of RunePage
        end
        @book.summonerId.should be_instance_of Fixnum
      end
    end

  end

  describe RunePage do
    before :all do
      json_mockup = JSON.parse('{"id": 27005798,"slots": [{"runeSlotId": 1,"rune": {"id": 5273,"description": "+0.87 magic penetration","name": "Greater Mark of Magic Penetration","tier": 3}},{"runeSlotId": 2,"rune": {"id": 5273,"description": "+0.87 magic penetration","name": "Greater Mark of Magic Penetration","tier": 3}},{"runeSlotId": 3,"rune": {"id": 5273,"description": "+0.87 magic penetration","name": "Greater Mark of Magic Penetration","tier": 3}}],"name": "fulltank ap","current": false}')
      @page = RunePage.new(json_mockup)
    end

    describe "#new" do
      it "should initilalize a rune page" do
        @page.should be_instance_of RunePage
      end

      it "should initilalize with correct params" do
        @page.id.should be_instance_of Fixnum
        @page.name.should be_instance_of String
        @page.slots.should be_instance_of Hash
        @page.slots.each do |key,slot|
          slot.should be_instance_of Rune
        end
      end
    end
  end

  describe Rune do
    before :all do
      json_mockup = JSON.parse('{"id": 5273,"description": "+0.87 magic penetration","name": "Greater Mark of Magic Penetration","tier": 3}')
      @rune = Rune.new(json_mockup)
    end

    describe "#new" do
      it "should init a talent" do
        @rune.should be_instance_of Rune
      end

      it "should init with correct params" do
        @rune.description.should be_instance_of String
        @rune.id.should be_instance_of Fixnum
        @rune.name.should be_instance_of String
        @rune.tier.should be_instance_of Fixnum
      end
    end
  end

end
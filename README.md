[![Build Status](https://travis-ci.org/danijoo/Sightstone.svg?branch=master)](https://travis-ci.org/danijoo/Sightstone)
[![Gem Version](https://badge.fury.io/rb/sightstone.png)](http://badge.fury.io/rb/sightstone)
[![Dependency Status](https://gemnasium.com/danijoo/Sightstone.svg)](https://gemnasium.com/danijoo/Sightstone)


Sightstone
=======

Sightstone is a ruby wrapper for riots league of legends developer api ([http://developer.riotgames.com](http://developer.riotgames.com)). Please note that you need an api key from riot in order to use this gem.


Installation
-------
Just install the gem:
```
gem install sightstone
```

If you want to build it by your own:
```
git clone https://github.com/danijoo/Sightstone.git
cd Sightstone
gem build sightstone.gemspec
gem install sightstone-x.x.x.gem
```

Usage
-------
Sightstone is divided into several modules, each controlled by the base class 'Sightstone'. To use it, simply `require 'sightstone'`.

Currently available modules are:
  summoner, game, league, stats, champion, teams and ddragon
  
Below are usage examples for 2 of the modules. You can review the code to get an idea about what is currently possible and what isnt. Especially the module classes under `sightstone/modules` should be interessting for that. Working on a wiki begins as soon as i bring myself to comment my code properly.

###Examples

Lets find dyrus

```
require 'sightstone'
sightstone = Sightstone::Sightstone.new('your_api_key', 'na')

summoner = sightstone.summoner.summoner 'dyrus' # gets the summoner by its name OR id

summoner.name
    => "Dyrus"
summoner.id
    => 5908
```

.. and his rune pages

``` 
require 'sightstone'
sightstone = Sightstone::Sightstone.new('your_api_key', 'na')

rune_book = sightstone.summoner.runes 5908 # 5908 is the summoner ID, you can pass a summoner object, too!
rune_book.pages.size
    => 20
    
page = rune_book.pages[0]
page.name
    => "Jax 2"
page.current
    => false
page.slots[1]
    => => #<Sightstone::Rune:0x007fae98b55c40 @id=5245, @description="+0.95 attack damage", @name="Greater Mark of Attack Damage", @tier=3>
```

Now things get tricky:
Lets get all games where dyrus played tryndamere (champion id = 23) in a single call using code blocks:

```
require 'sightstone'
sightstone = Sightstone::Sightstone.new('your_api_key', 'na')
dyrus = sightstone.summoner.summoner("Dyrus")

tryn_games = []
sightstone.game.recent(dyrus) do |history|
  history.games.each do |game|
   tryn_games << game if game.championId == 23 # 23 stands for tryndamere 
  end
end

tryn_games.size
  => 2
```

A full documentation of the gem can be viewed at rdoc.info: http://rdoc.info/github/danijoo/Sightstone or build via yard from the source.
Feel free to contact me if you need any help.


License
-------
Licensed under the MIT License - Feel free to take on world domination with it.

Feedback
-------
Issues, suggestions, pull requests and whatever Dr. Mundo pleases are welcome.
If you want to contact me: __danijob88 at googlemail.com__



_This product is not endorsed, certified or otherwise approved in any way by Riot Games, Inc. or any of its affiliates._

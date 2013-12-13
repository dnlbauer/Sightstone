Sightstone
=======

Sightstone is a ruby wrapper for riots league of legends developer api ([http://developer.riotgames.com](http://developer.riotgames.com)). Please not that you need an api key from riot in order to use this gem


Installation
-------
Clone this rep, build the gem and install it:
```
cd Sightstone
gem build sightstone.gemspec
gem install sightstone-x.x.x.gem
```

Usage Examples
-------
Sightstone is divided into several modules, each controlled by the base class 'Sightstone'. To use it, simply `require 'sightstone'`

Currently available modules are:
  summoner (summoner, runes, masteries), game, league, stats, champion
  
Below are usage examples for 2 of the modules. You can review the code to get an idea about what is currently possible and what isnt. Especially the module classes under `sightstone/modules` should be interessting for that. Working on a wiki begins as soon as i bring myself to comment my code properly.

### Summoner
The summoner module handles all calls to the summoner api (summoner, runes, masteries)

Examples:
```
require 'sightstone'
sightstone = Sightstone.new('your_api_key', 'na')

# gets the summoner by its name OR id
summoner = sightstone.summoner.summoner 'dyrus'

summoner.name
    => "Dyrus"
summoner.id
    => 5908
```

``` 
require 'sightstone'
sightstone = Sightstone.new('your_api_key', 'na')

# gets the runebook of the summoner or a summoners id    
rune_book = sightstone.summoner.runes 5908
rune_book.pages.size
    => 20
    
page = rune_book.pages[0]
page.name
    => "Jax 2"
page.current
    => false
page.slots[1]
    => => #<Rune:0x007fae98b55c40 @id=5245, @description="+0.95 attack damage", @name="Greater Mark of Attack Damage", @tier=3>
```

### Game
This module handles calls to the game api (used to receive summoners match history)

Example:
```
require 'sightstone'
sightstone = Sightstone.new('your_api_key', 'na')

summoner dyrus = sightstone.summoner.summoner("Dyrus")
history = sightstone.game.recent(dyrus)

history.games.size
    => 10

game = history.games[0]
game.gameType
    => "MATCHED_GAME"
game.createDate
    => 1386503866142
game.statistics[1].name
    => "GOLD_EARNED"
game.statistics[1].value
    => 7948
```

TODO
-------
- Teams
- Non-api calls to the datadragon

License
-------
Licensed under the MIT License - Feel free to take on world domination with it.

Feedback
-------
Issues, suggestions, pull requests and whatever Dr. Mundo pleases are welcome.
If you want to contact me: __danijob88 at googlemail.com__



_This product is not endorsed, certified or otherwise approved in any way by Riot Games, Inc. or any of its affiliates._

/datum/sector
  var/name = ""
  var/id
  var/unique = FALSE
  var/frequency = 10
  var/visited = FALSE

  var/sector_type = "bad sector"

  // var/datum/faction/controlling_faction
  
  var/parallax_icon = "empty"

  var/datum/planet/planet
  var/datum/station/station

  var/list/connected_sectors = list()
  var/generated_sectors = FALSE

  var/planet_prob = 75
  var/station_prob = 50


/datum/sector/New()
  SSftl_navigation.sector_count ++
  id = "[SSftl_navigation.sector_count]"
  SSftl_navigation.all_sectors[id] += src
  for(var/i in 1 to rand(2,4))
    name += pick(SSftl_navigation.sector_name_fragments)
  name = capitalize(name) + " [id]"
  if(prob(planet_prob))
    var/p = pickweight(SSftl_navigation.planet_types)
    planet = new p

  if(prob(station_prob))
    station = new /datum/station
    
  parallax_icon = pickweight(list("empty" = 3, "fog" = 1, "rocks" = 1)) //temp to prove it works


/datum/sector/Destroy()
  if(planet)
    qdel(planet)
  if(station)
    qdel(station)
  return ..()

/datum/sector/empty
  sector_type = "empty sector"

/datum/planet
  var/name = "null planet"
  var/frequency = 1
  
  var/parallax_icon = "habitable"


/datum/planet/habitable
  name = "habitable planet"

/datum/planet/ice
  name = "ice planet"
  parallax_icon = "ice"

/datum/planet/barren
  name = "barren planet"
  parallax_icon = "gas"

/datum/planet/gas
  name = "gas giant"
  parallax_icon = "gas"

/datum/planet/lava
  name = "lava planet"
  parallax_icon = "lava"

/datum/planet/water
  name = "water world"
  parallax_icon = "oshan"


/datum/station
  var/name = "station"
  var/unique = FALSE
  var/frequency = 10


/*
In a nutshell, named sectors are custom sectors that we define.
They will only spawn once and will not randomly generate. It's all down to coders.
Want to recreate Dolos? Go for it
Sol 3 sure why not.

*/
/datum/sector/named
  name = "Named Sector"
  unique = TRUE
  frequency = -1

/datum/sector/named/New()
  SSftl_navigation.sector_count ++
  id = "[SSftl_navigation.sector_count]"
  SSftl_navigation.all_sectors[id] += src

  name += " [id]" //temp line please ignore

  if(!planet && prob(planet_prob))
    var/p = pickweight(SSftl_navigation.planet_types)
    planet = new p

  if(prob(station_prob))
    station = new /datum/station    

/datum/sector/named/dolos
  name = "Dolos 1" //The intention is to let an antag emag the console to force a jump to this system.
  frequency = -1 //Will not randomly spawn, but is unique
  sector_type = "Syndicate Homeworld"

/datum/sector/named/nt_home
  name = "Gooftown"
  frequency = -1 //Will not randomly spawn, but is unique
  sector_type = "Nanotrasen Homeworld"
  planet = new /datum/planet/habitable

/datum/sector/named/sol3
  name = "Sol 3"
  frequency = 1
  sector_type = "Sol Gov Homeworld"
  planet = new /datum/planet/habitable

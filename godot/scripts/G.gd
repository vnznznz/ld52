extends Node

var NEEDS_PLANET = "needs_planet"
var NEEDS_SUN = "needs_sun"
var NEEDS_RAIN = "needs_rain"
var NEEDS_HARVESTER = "needs_harvester"

var NEEDS_HARVEST_EVENT = "needs_harvest_event"

var label = Label.new()
var DEFAULT_FONT = label.get_font("")


var PLANT_SUN_ANGLE = 55
var PLANT_RAIN_ANGLE = 40
var PLANT_HARVESTER_ANGLE = 60

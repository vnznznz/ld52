extends Node

var NEEDS_PLANET = "needs_planet"
var NEEDS_SUN = "needs_sun"
var NEEDS_RAIN = "needs_rain"
var NEEDS_HARVESTER = "needs_harvester"

var NEEDS_WIN = "needs_win"

var NEEDS_HARVEST_EVENT = "needs_harvest_event"

var label = Label.new()
var DEFAULT_FONT = label.get_font("")


var PLANT_SUN_ANGLE = 55
var PLANT_RAIN_ANGLE = 40
var PLANT_HARVESTER_ANGLE = 60

# var SOUNDS = []
var SOUNDS = [
	preload("res://assets/sounds/A3_new.wav"),
	preload("res://assets/sounds/Bb3_new.wav"),
	preload("res://assets/sounds/C3_new.wav"),
	preload("res://assets/sounds/Db3_new.wav"),
	preload("res://assets/sounds/Db4_new.wav"),
	preload("res://assets/sounds/Eb3_new.wav"),
	preload("res://assets/sounds/F3_new.wav"),
	preload("res://assets/sounds/G3_new.wav")
]

var BLIPS = []
var _BLIPS = [
	preload("res://assets/sounds/Eb5_blib.wav"),
	preload("res://assets/sounds/Bb5_blib.wav"),
	preload("res://assets/sounds/C5_blib.wav"),
	preload("res://assets/sounds/D5_blib.wav")	
]

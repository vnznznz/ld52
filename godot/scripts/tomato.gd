extends Node2D


# Declare member variables here. Examples:
# var a = 2
var SUN_EXPOSURE_DECAY = 100
var SUN_EXPOSURE_MAG = 200
var sun_accu = 0

var EXPOSURE_LEVELS = [
	{"sun": 0},
	{"sun": 100},
	{"sun": 200},
	{"sun": 300},
	{"sun": 400},
]


var has_sun_exposure:bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.frame = 0


func _process(delta):
	if has_sun_exposure:
		sun_accu += SUN_EXPOSURE_MAG * delta
	else: 
		sun_accu -= SUN_EXPOSURE_DECAY * delta
	
	if sun_accu  < 0:
		sun_accu = 0
	var exposure_idx = 0
	for i in range(len(EXPOSURE_LEVELS)):
		if sun_accu >= EXPOSURE_LEVELS[i]["sun"]:
			exposure_idx = i
	
	$sprite.frame = exposure_idx

func _on_grow_rate_timeout():
	$sprite.frame = ($sprite.frame + 1) % 5
	print($sprite.frame)

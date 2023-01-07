extends Node2D


# Declare member variables here. Examples:
# var a = 2
var SUN_EXPOSURE_STRENGTH:float = 200.0
var SUN_EXPOSURE_DECAY:float = 100.0

var RAIN_EXPOSURE_STRENGTH:float = 100.0
var RAIN_EXPOSURE_DECAY:float = 75.0

var HARVESTER_EXPOSURE_STRENGTH:float = 300.0
var HARVESTER_EXPOSURE_DECAY:float = 25.0


var current_exposure:float = 0
var current_growth_level:int = 0
var has_required_exposure:bool = false

enum NEEDS {
	SUN = 0,
	SHADE = 1,
	RAIN = 2,
	NORAIN = 3, 
	HARVEST = 4
}


var GROWTH_LEVELS = [
	[NEEDS.SUN, 400],
	[NEEDS.SHADE, 600],
	[NEEDS.RAIN, 400],
	[NEEDS.SUN, 400],
	[NEEDS.HARVEST, 100],
]


var has_sun_exposure:bool = false
var has_rain_exposure:bool = false
var has_harvester_exposure:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.frame = 0


func _process(delta):
	update()
	var current_need =  GROWTH_LEVELS[current_growth_level][0]
	var required_exposure = GROWTH_LEVELS[current_growth_level][1]
	
	if current_need == NEEDS.SUN:
		if has_sun_exposure:
			current_exposure += SUN_EXPOSURE_STRENGTH * delta
			has_required_exposure = true
		else:
			current_exposure -= SUN_EXPOSURE_DECAY * delta
			has_required_exposure = false
	elif current_need == NEEDS.SHADE:
		if has_sun_exposure:
			current_exposure -= SUN_EXPOSURE_STRENGTH * delta
			has_required_exposure = false
		else:
			current_exposure += SUN_EXPOSURE_DECAY * delta
			has_required_exposure = true
	elif current_need == NEEDS.RAIN:
		if has_rain_exposure:
			current_exposure += RAIN_EXPOSURE_STRENGTH * delta
			has_required_exposure = true
		else:
			current_exposure -= RAIN_EXPOSURE_DECAY * delta
			has_required_exposure = false
	elif current_need == NEEDS.NORAIN:
		if has_rain_exposure:
			current_exposure -= RAIN_EXPOSURE_STRENGTH * delta
			has_required_exposure = false
		else:
			current_exposure += RAIN_EXPOSURE_DECAY * delta
			has_required_exposure = true
	
	
	if current_exposure >= required_exposure:
		current_growth_level += 1
		current_exposure = GROWTH_LEVELS[current_growth_level][1] * 0.5
	elif current_exposure <= 0 and current_growth_level > 0:
		current_growth_level -= 1
		current_exposure = GROWTH_LEVELS[current_growth_level][1] * 0.5
	
	current_exposure = clamp(current_exposure, 0, required_exposure)
	
	$icon.frame = GROWTH_LEVELS[current_growth_level][0]
	$sprite.frame = current_growth_level


func _draw():
	var marker_color = Color.gray
	var required_exposure = GROWTH_LEVELS[current_growth_level][1]
	if has_required_exposure:
		marker_color = Color.yellowgreen
	draw_circle($icon.position, 5, marker_color)
	draw_circle($icon.position, 5 + 30 * (current_exposure / required_exposure), marker_color)

	
	
func _on_grow_rate_timeout():
	$sprite.frame = ($sprite.frame + 1) % 5
	print($sprite.frame)

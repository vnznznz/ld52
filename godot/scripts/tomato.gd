extends Node2D


# Declare member variables here. Examples:
# var a = 2
var SUN_EXPOSURE_STRENGTH:float = 100.0
var SUN_EXPOSURE_DECAY:float = 50.0

var RAIN_EXPOSURE_STRENGTH:float = 50.0
var RAIN_EXPOSURE_DECAY:float = 37.5

var HARVESTER_EXPOSURE_STRENGTH:float = 300.0
var HARVESTER_EXPOSURE_DECAY:float = 25.0

var current_exposure:float = 0
var current_growth_level:int = 0
var has_required_exposure:bool = false
var is_need_active:bool = true


enum NEEDS {
	SUN = 0,
	SHADE = 1,
	RAIN = 2,
	NORAIN = 3, 
	HARVEST = 4
}


var GROWTH_LEVELS = [
	[NEEDS.SUN, 3],
	[NEEDS.RAIN, 1],
	[NEEDS.SUN, 2],
	[NEEDS.RAIN, 2],
	[NEEDS.HARVEST, 1],
]


var has_sun_exposure:bool = false
var has_rain_exposure:bool = false
var has_harvester_exposure:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.frame = 0
	
	for sound in G.SOUNDS:
		var player = AudioStreamPlayer2D.new()
		player.set_stream(sound)
		$notes.add_child(player)
	
	for blip in G.BLIPS:
		var player = AudioStreamPlayer2D.new()
		player.set_stream(blip)
		$blips.add_child(player)

func sound():
	var candidates = []
	for note in $notes.get_children():
		if not note.playing:
			candidates.append(note)
	if len(candidates) > 0:
		var selected_sound_idx = randi() % len(candidates)	
		candidates[selected_sound_idx].play()

func blip():
	var candidates = []
	for note in $blips.get_children():
		if not note.playing:
			candidates.append(note)
	if len(candidates) > 0:
		var selected_sound_idx = randi() % len(candidates)	
		candidates[selected_sound_idx].play()

func receive_sun_power():
	if not is_need_active:
		return
	var current_need =  GROWTH_LEVELS[current_growth_level][0]
	var required_exposure = GROWTH_LEVELS[current_growth_level][1]
	if current_need == NEEDS.SUN:
		current_exposure += 1
		blip()
	# elif current_need == NEEDS.SHADE:
	#	current_exposure -= 1

func receive_rain():
	if not is_need_active:
		return
	var current_need =  GROWTH_LEVELS[current_growth_level][0]
	var required_exposure = GROWTH_LEVELS[current_growth_level][1]
	if current_need == NEEDS.RAIN:
		current_exposure += 1
		blip()

func harvest():
	if not is_need_active:
		return
	var current_need =  GROWTH_LEVELS[current_growth_level][0]
	var required_exposure = GROWTH_LEVELS[current_growth_level][1]
	if current_need == NEEDS.HARVEST:
		sound()
		current_growth_level = 0
		get_tree().call_group(G.NEEDS_HARVEST_EVENT, "on_harvest")


func _process(_delta):
	update()
	#var current_need =  GROWTH_LEVELS[current_growth_level][0]
	var required_exposure = GROWTH_LEVELS[current_growth_level][1]
	
	if current_exposure >= required_exposure:
		current_growth_level += 1
		excite()
		sound()
		$enable_need.start(rand_range(1, 3))
		is_need_active = false
		current_exposure = 0
	elif current_exposure < 0 and current_growth_level > 0:
		current_growth_level -= 1
	
	current_exposure = clamp(current_exposure, 0, required_exposure)
	
	$icon.frame = GROWTH_LEVELS[current_growth_level][0]
	$icon.visible = is_need_active
	
	$sprite.frame = current_growth_level

func needs_sun():
	return GROWTH_LEVELS[current_growth_level][0] == NEEDS.SUN
	
func needs_rain():
	return GROWTH_LEVELS[current_growth_level][0] == NEEDS.RAIN

func needs_harvest():
	return GROWTH_LEVELS[current_growth_level][0] == NEEDS.HARVEST

func excite():
	$excite.restart()

func _draw():
	var marker_color = Color.gray
	var required_exposure = GROWTH_LEVELS[current_growth_level][1]
	if has_required_exposure:
		marker_color = Color.yellowgreen
	
	
func _on_grow_rate_timeout():
	$sprite.frame = ($sprite.frame + 1) % 5
	print($sprite.frame)


func _on_enable_need_timeout():
	is_need_active = true

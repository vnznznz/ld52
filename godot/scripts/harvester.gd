extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var collectors = {}

var harvest_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(G.NEEDS_HARVEST_EVENT)
	yield(get_tree(), "idle_frame")
	get_tree().call_group(G.NEEDS_HARVESTER, "set_harvester", self)
	

func send_collector(plant_spot):
	if not collectors.has(plant_spot):
		collectors[plant_spot] = 0
	  
func stop_sending_collector(plant_spot):
	collectors.erase(plant_spot)

func on_harvest():
	harvest_count += 1
	$harvest_label.text = "%s" %[harvest_count]

func _process(delta):
	update()
	for plant_spot in collectors:	
		collectors[plant_spot] += delta
		if collectors[plant_spot] >= 3:
			plant_spot.harvest()
			collectors[plant_spot] -= 3
			


func _draw():	
	for plant_spot in collectors:
		var delta = to_local(plant_spot.global_position) * (1-(collectors[plant_spot]/3.0) ) 
		draw_circle(delta, 10, Color.purple)

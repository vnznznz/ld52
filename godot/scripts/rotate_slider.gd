extends VSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var planet:Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(G.NEEDS_PLANET)

func set_planet(planet):
	self.planet = planet


func _process(delta):
	if is_instance_valid(planet):
		planet.rotation_degrees = 180 - self.value

extends HSlider


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
	$Label.text = "%s" %[self.value]
	if is_instance_valid(planet):		
		if self.value <=40:
			planet.rotate(-lerp(0.025, 0.05, (40-self.value) / 40))
		elif self.value <=170:
			planet.rotate(-lerp(0, 0.025, (170-self.value) / 170))
		elif self.value >=320:
			planet.rotate(lerp(0.025, 0.05, (self.value-320) / 40))
		elif self.value >=190:
			planet.rotate(lerp(0, 0.025, (self.value-190) / 190))
		#planet.rotation_degrees = 180 - self.value

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
	$Arrow1Right.visible = false
	$Arrow2Right.visible = false
	$Arrow1Left.visible = false
	$Arrow2Left.visible = false
	if is_instance_valid(planet):		
		if self.value <=40:
			planet.rotate(-lerp(0.5, 2, (40-self.value) / 40) * delta)
			$Arrow2Left.visible = true
		elif self.value <=170:
			planet.rotate(-lerp(0, 0.5, (170-self.value) / 170) * delta)
			$Arrow1Left.visible = true
		elif self.value >=320:
			planet.rotate(lerp(0.5, 2, (self.value-320) / 40) * delta)
			$Arrow2Right.visible = true
		elif self.value >=190:
			planet.rotate(lerp(0, 0.5, (self.value-190) / 190) * delta)
			$Arrow1Right.visible = true
		#planet.rotation_degrees = 180 - self.value

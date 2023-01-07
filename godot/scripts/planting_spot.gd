extends Node2D


var planet:Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(G.NEEDS_PLANET)
	
	
func set_planet(planet):
	self.planet = planet
	
	self.rotation = to_local(planet.global_position).angle() - PI/2
	update()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _draw():
	if not is_instance_valid(planet):
		return
	draw_circle(to_local(planet.global_position), 5, Color.yellow)
	draw_line(Vector2.ZERO, to_local(planet.global_position), Color.yellow, 4)

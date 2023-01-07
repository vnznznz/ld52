extends Node2D

export var has_active_plant:bool = false

var planet:Node2D
var sun:Node2D

var has_sun_exposure:bool = true



# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(G.NEEDS_PLANET)
	add_to_group(G.NEEDS_SUN)
	
func set_planet(planet):
	self.planet = planet
	
	self.rotation = to_local(planet.global_position).angle() - PI/2
	update()

func set_sun(sun):
	self.sun = sun

func _process(delta):
	update()
	var angle_to_sun:float = rad2deg(to_local(sun.global_position).angle())
	var left_bound = -90 - G.PLANT_SUN_ANGLE
	var right_bound = -90 + G.PLANT_SUN_ANGLE
	if angle_to_sun >= left_bound and angle_to_sun <= right_bound:
		has_sun_exposure = true
	else: 
		has_sun_exposure = false
		
	if has_active_plant:
		$plant.visible = true
		$plant/tomato.has_sun_exposure = has_sun_exposure
	else:
		$plant.visible = false
		

func _draw():
	if not is_instance_valid(planet):
		return
		
	# draw_circle(to_local(planet.global_position), 5, Color.yellow)
	# draw_line(Vector2.ZERO, to_local(planet.global_position), Color.yellow, 4)
	# draw_line(Vector2.ZERO, Vector2.UP * 200, Color.darkgoldenrod, 4)	
	# draw_string(G.DEFAULT_FONT, (Vector2.UP * 200),"%f°" % [angle_to_sun])
	
	var marker_color = Color.darkgoldenrod
	if has_sun_exposure:
		marker_color = Color.green
		draw_line(Vector2.ZERO, to_local(sun.global_position), Color.yellow, 1)
	
		draw_line(Vector2.ZERO, (Vector2.UP * 200).rotated(-PI/4), marker_color, 4)
		draw_line(Vector2.ZERO, (Vector2.UP * 200).rotated(PI/4), marker_color, 4)

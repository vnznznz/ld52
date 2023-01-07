extends Node2D

export var has_active_plant:bool = false

var planet:Node2D
var sun:Node2D
var rain:Node2D
var harvester:Node2D

var has_sun_exposure:bool = false
var has_rain_exposure:bool = false
var has_harvester_exposure:bool = false

var angle_to_sun:float = 0
var angle_to_rain:float = 0
var angle_to_harvester:float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(G.NEEDS_PLANET)
	add_to_group(G.NEEDS_SUN)
	add_to_group(G.NEEDS_RAIN)
	add_to_group(G.NEEDS_HARVESTER)
	
func set_planet(planet):
	self.planet = planet	
	self.rotation = to_local(planet.global_position).angle() - PI/2
	update()

func set_sun(sun):
	self.sun = sun
	
func set_rain(rain):
	self.rain = rain
	
func set_harvester(harvester):
	self.harvester = harvester
	
	
func has_exposure(current_angle, bounds):
	var left =  -90 - bounds
	var right =  -90 + bounds
	if current_angle >= left and current_angle <= right:
		return true		
	return false
func _process(delta):	

	if not is_instance_valid(sun):
		return
		
	update()
	angle_to_sun = rad2deg(to_local(sun.global_position).angle())
	angle_to_rain = rad2deg(to_local(rain.global_position).angle())
	angle_to_harvester = rad2deg(to_local(harvester.global_position).angle())
	
	has_sun_exposure = has_exposure(angle_to_sun, G.PLANT_SUN_ANGLE)
	has_rain_exposure = has_exposure(angle_to_rain, G.PLANT_RAIN_ANGLE)
	has_harvester_exposure = has_exposure(angle_to_harvester, G.PLANT_HARVESTER_ANGLE)

	if has_active_plant:
		$plant.visible = true
		$plant/tomato.has_sun_exposure = has_sun_exposure
		$plant/tomato.has_rain_exposure = has_rain_exposure
		$plant/tomato.has_harvester_exposure = has_harvester_exposure
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
		draw_line(Vector2.ZERO, to_local(sun.global_position), Color.yellow, 4)
	if has_rain_exposure:
		marker_color = Color.green
		draw_line(Vector2.ZERO, to_local(rain.global_position), Color.blue, 4)
	if has_harvester_exposure:
		marker_color = Color.green
		draw_line(Vector2.ZERO, to_local(harvester.global_position), Color.purple, 1)

		# draw_line(Vector2.ZERO, (Vector2.UP * 200).rotated(-PI/4), marker_color, 4)
		# draw_line(Vector2.ZERO, (Vector2.UP * 200).rotated(PI/4), marker_color, 4)

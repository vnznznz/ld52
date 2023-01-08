extends Node2D
export var radius = 200 
export var speed:float = 2 

var planet:Node2D
var rain_delivery = {}
var angle = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(G.NEEDS_PLANET)
	yield(get_tree(), "idle_frame")
	get_tree().call_group(G.NEEDS_RAIN, "set_rain", self)
	
	

func set_planet(planet):
	self.planet = planet

func send_rain(plant_spot):
	if not rain_delivery.has(plant_spot):
		rain_delivery[plant_spot] = 0
	  
func stop_sending_rain(plant_spot):
	rain_delivery.erase(plant_spot)

func _process(delta):
	if not is_instance_valid(planet):
		return
	# update()
	
	angle += speed * delta
	self.global_position = Vector2(planet.position.x + radius * cos(angle), planet.position.y + radius * sin(angle))
	# self.global_position = get_global_mouse_position()
	self.rotation = atan2(planet.position.y - position.y, planet.position.x - position.x) - PI/2
	
	update()
	for plant_spot in rain_delivery:	
		rain_delivery[plant_spot] += delta
		if rain_delivery[plant_spot] >= 2:
			plant_spot.receive_rain()
			rain_delivery[plant_spot] -= 2
	
func _draw():
	if not is_instance_valid(planet):
		return
	#draw_circle(to_local(planet.global_position), 5, Color.yellow)
	#draw_line(Vector2.ZERO, to_local(planet.global_position), Color.yellow, 4)
	
	for plant_spot in rain_delivery:
		var delta = to_local(plant_spot.global_position) * (rain_delivery[plant_spot] / 2)
		draw_circle(delta, 15, Color.blue)
	

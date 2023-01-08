extends Node2D

export var radius = 200 
export var speed:float = 2 

var planet:Node2D

var angle = 0 

var power_delivery = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(G.NEEDS_PLANET)
	yield(get_tree(), "idle_frame")
	get_tree().call_group(G.NEEDS_SUN, "set_sun", self)
	
	

func set_planet(planet):
	self.planet = planet

func send_power(plant_spot):
	if not power_delivery.has(plant_spot):
		power_delivery[plant_spot] = 0
	  
func stop_sending_power(plant_spot):
	power_delivery.erase(plant_spot)
	
func _process(delta):
	if not is_instance_valid(planet):
		return
	update()
	
	angle += speed * delta
	self.global_position = Vector2(planet.position.x + radius * cos(angle), planet.position.y + radius * sin(angle))
	# self.global_position = get_global_mouse_position()
	self.rotation = atan2(planet.position.y - position.y, planet.position.x - position.x) + PI/2
	
	for plant_spot in power_delivery:	
		power_delivery[plant_spot] += delta
		if power_delivery[plant_spot] >= 1:
			plant_spot.receive_sun_power()
			power_delivery[plant_spot] -= 1

func _draw():
	if not is_instance_valid(planet):
		return		
	#draw_circle(to_local(planet.global_position), 5, Color.yellow)
	#draw_line(Vector2.ZERO, to_local(planet.global_position), Color.yellow, 4)
	
	for plant_spot in power_delivery:
		var delta = to_local(plant_spot.global_position) * power_delivery[plant_spot]
		draw_circle(delta, 10, Color.gold)
	

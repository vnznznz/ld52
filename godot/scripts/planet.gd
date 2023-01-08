extends Node2D

var dragging:bool = false
var drag_start:Vector2
var drag_end:Vector2
var rotate_mag:float = 0
func _ready():
	add_to_group(G.NEEDS_HARVEST_EVENT)
	yield(get_tree(), "idle_frame")
	get_tree().call_group(G.NEEDS_PLANET, "set_planet", self)


func easeInCirc(x):
	return 1 - sqrt(1 - pow(x, 2));
	
	
func on_harvest():
	var candidates_to_unlock = []
	for plant_spot in $planting_spots.get_children():
		if not plant_spot.has_active_plant:
			candidates_to_unlock.append(plant_spot)
	
	if len(candidates_to_unlock) > 0:
		candidates_to_unlock[randi() % len(candidates_to_unlock)].activate_plant()


		
func _draw():
	if dragging == false:
		return
		
	draw_circle(to_local(drag_start), 40, Color.rebeccapurple)
	draw_line(to_local(drag_start), to_local(drag_end), Color.rebeccapurple, 10)


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if dragging == false:
				drag_start = get_global_mouse_position()
				drag_end = drag_start
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		drag_end = get_global_mouse_position()

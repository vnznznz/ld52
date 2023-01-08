extends Node2D

var dragging:bool = false
var drag_start:Vector2
var drag_end:Vector2
var rotate_mag:float = 0
func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group(G.NEEDS_PLANET, "set_planet", self)


func easeInCirc(x):
	return 1 - sqrt(1 - pow(x, 2));

func _process(delta):	
	pass
	
	#if dragging:
	#	update()		
	#	var drag = (drag_end - drag_start)
	#	rotate_mag = easeInCirc(clamp(drag.length(), 0, 150) / 500) * sign((drag_end - drag_start).normalized().x + (drag_start - drag_end).normalized().y) # yes
	#	self.look_at(get_global_mouse_position())
	#	self.rotate(PI/2)
		
		
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

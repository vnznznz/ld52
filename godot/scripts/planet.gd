extends Node2D

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group(G.NEEDS_PLANET, "set_planet", self)
	


func _process(delta):
	pass

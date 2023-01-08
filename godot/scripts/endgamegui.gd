extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(G.NEEDS_WIN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_win():
	visible = true

func _on_restart_pressed():
	get_tree().reload_current_scene()


func _on_keep_playing_pressed():
	visible = false

extends Button

var select_scene = load("res://ui/Menu/Select.tscn") # keep it load instead of preload, because the select scene uses preload


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	SceneManagerGlobal.change_scene_to_packed(select_scene)
	pass # Replace with function body.

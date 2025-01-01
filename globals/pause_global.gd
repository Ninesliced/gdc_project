extends Node

enum PauseType { 
	PAUSE,
	SHOP,
	NONE
}

var current_pause_type : PauseType = PauseType.NONE

var pause_menu_scene : PackedScene = preload("res://ui/Pause/pause.tscn")
var pause_menu : Pause = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu = pause_menu_scene.instantiate() as Pause
	add_child(pause_menu)
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

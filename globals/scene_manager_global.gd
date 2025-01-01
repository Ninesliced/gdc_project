extends Node

var transition_scene : PackedScene = preload("res://ui/transition/transition.tscn")
var transition : Transition = null


func _ready() -> void:
	transition = transition_scene.instantiate() 
	add_child(transition)

func change_scene_to_packed(scene : PackedScene) -> void:
	transition.animation_player.play("begin")
	await transition.animation_player.animation_finished
	get_tree().change_scene_to_packed(scene)
	await get_tree().process_frame
	transition.animation_player.play("end")

	pass # Replace with function body.
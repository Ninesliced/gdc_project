extends CanvasLayer
class_name GameUI

var player : Player = null

var text_scene = preload("res://ui/InGameUI/label_ui.tscn")

@onready var counter_data_container : VBoxContainer = $MarginContainer/HBoxContainer/CounterDataContainer


func _ready():
	if player != null:
		hide()
		

func set_player(player: Player) -> void:
	self.player = player
	show()
	print("Player set")
	set_ui()

func set_ui() -> void:
	var counter_data : CounterData = player._player_counter
	add_text_to_parent("Score: " + str(counter_data.score), counter_data_container)
	pass

func add_text_to_parent(string : String, parent : Node) -> void:
	var text_scene_instance = text_scene.instantiate()
	text_scene_instance.set_text(string)
	parent.add_child(text_scene_instance)
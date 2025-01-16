extends CanvasLayer
class_name GameUI

var player : Player = null

var text_scene = preload("res://ui/InGameUI/label_ui.tscn")
var texts : Dictionary = {}
@onready var counter_data_container : VBoxContainer = $MarginContainer/HBoxContainer/CounterDataContainer


func _ready():
	UiGlobal.in_game_ui_node = self
	if player != null:
		hide()

func set_player(player: Player) -> void:
	self.player = player
	show()
	print("Player set")
	set_ui()
	player._player_counter.connect("on_counter_data_changed", set_ui)

func update_ui() -> void:
	set_ui()

func set_ui() -> void:
	var counter_data : CounterData = player._player_counter
	add_text_to_parent("Score", "Score: " + str(counter_data.score), counter_data_container)
	add_text_to_parent("Base coin", "Base coin: " + str(counter_data.base_coin), counter_data_container)
	pass

func add_text_to_parent(key, string : String, parent : Node) -> void:
	if texts.has(key):
		texts[key].set_text(string)	
		return
	var text_scene_instance = text_scene.instantiate()
	texts[key] = text_scene_instance
	text_scene_instance.set_text(string)
	parent.add_child(text_scene_instance)

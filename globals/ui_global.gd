extends Node


var in_game_ui_scene = preload("res://ui/InGameUI/GameUI.tscn")
var in_game_ui_node : GameUI = null

func _ready():
	var in_game_ui = in_game_ui_scene.instantiate()
	add_child(in_game_ui)
	in_game_ui_node = in_game_ui


var ui_text_value_scene = preload("res://ui/name_value_ui.tscn")

func get_ui_stats_from_dict(stats : Dictionary, add_color = true) -> Array[NameValueUI]:
	
	var stats_list : Array[NameValueUI] = []
	for stat in stats:
		var name_value_ui_instance : NameValueUI = ui_text_value_scene.instantiate()
		var formated_name = stat.replace("_", " ")
		name_value_ui_instance.set_name_value(formated_name, str(stats[stat]))

		if add_color and GameData.name_colors.has(stat):
			name_value_ui_instance.set_value_color(GameData.name_colors[stat])

		stats_list.append(name_value_ui_instance)
	return stats_list
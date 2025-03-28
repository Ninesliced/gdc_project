extends Node


var in_game_ui_scene = preload("res://ui/InGameUI/GameUI.tscn")
var in_game_ui_node : GameUI = null

var retry_scene = preload("res://ui/Retry/retry.tscn")
var retry_node : RetryUI = null

func _ready():
	pass


var ui_text_value_scene = preload("res://ui/name_value_ui.tscn")

func hide_all():
	in_game_ui_node.hide()
	retry_node.hide()

# This function is used to get instance of NameValueUI from a dictionary
func get_ui_stats_from_dict(stats : Dictionary, add_color = true) -> Array[NameValueUI]:
	
	var stats_list : Array[NameValueUI] = []
	for stat in stats:
		var name_value_ui_instance : NameValueUI = ui_text_value_scene.instantiate()
		var formated_name = stat.replace("_", " ")
		var value = stats[stat]
			
		name_value_ui_instance.set_name_value(formated_name, str(value))

		if add_color and GameData.name_colors.has(stat):
			name_value_ui_instance.set_value_color(GameData.name_colors[stat])

		stats_list.append(name_value_ui_instance)
	return stats_list
extends Node2D

var selected_class : PlayerStats = null
var selected_class_box : ClassBox = null
var class_box_scene = preload("res://ui/Menu/class_box.tscn")
var world_scene = preload("res://scenes/world.tscn")
var list_class_boxes : Array = []

var name_value_ui_scene = preload("res://ui/name_value_ui.tscn")
var stats_ui_list : Array = []

@onready var control_ui : Control = $CanvasLayer/Control
@onready var grid_container: GridContainer = $CanvasLayer/Control/VBoxContainer/Panel/VScrollBar/ClassContainer
@onready var stats_container: VBoxContainer = $CanvasLayer/Control/VBoxContainer/Panel/NinePatchRect/StatsContainer
func _ready() -> void:
	get_tree().paused = false
	for character in GameData.list_available_characters:
		var class_box_instance = class_box_scene.instantiate()
		list_class_boxes.append(class_box_instance)
		class_box_instance.player_stats = character
		class_box_instance.connect("on_class_selected", select_class)
		grid_container.add_child(class_box_instance)
		
	pass # Replace with function body.

var delta_sin = 0
func _process(delta):
	delta_sin += delta
	if delta_sin >= 2 * PI:
		delta_sin -= 2 * PI
	control_ui.position.y = 2 + sin(delta_sin) * 2
	pass

func select_class(box : ClassBox) -> void:
	if selected_class_box != null:
		selected_class_box.deselect()
	selected_class_box = box
	selected_class = box.player_stats
	change_stat_display()
	selected_class_box.select()

func change_stat_display() -> void:
	for stat_ui in stats_ui_list:
		stat_ui.queue_free()
	stats_ui_list.clear()

	var new_stats = {
		"health": selected_class.health,
		"delay_reduction": str(selected_class.reduction_delay_boost * 100) + "%",
		"damage_multiplier": str(selected_class.damage_multiplier) + "X",
		"critical_chance": str(selected_class.critical_chance * 100) + "%",
		"critical_damage": str(selected_class.critical_damage * 100) + "%",
		"speed": selected_class.speed,
	}

	for stat in new_stats:
		var name_value_ui_instance :NameValueUI = name_value_ui_scene.instantiate()
		var formated_name = stat.replace("_", " ")
		name_value_ui_instance.set_name_value(formated_name, str(new_stats[stat]))
		if GameData.name_colors.has(stat):
			name_value_ui_instance.set_value_color(GameData.name_colors[stat])
		stats_ui_list.append(name_value_ui_instance)
		stats_container.add_child(name_value_ui_instance)

	pass # Replace with function body.

func _on_play_pressed() -> void:
	PlayerData.player_start_stats = selected_class
	SceneManagerGlobal.change_scene_to_packed(world_scene)

	SoundManagerGlobal.set_low_pass_filter("Music", false)
	# get_tree().change_scene_to_packed(world_scene)

	pass # Replace with function body.

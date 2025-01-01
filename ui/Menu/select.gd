extends Node2D

var selected_class : PlayerStats = null
var selected_class_box : ClassBox = null
var class_box_scene = preload("res://ui/Menu/class_box.tscn")
var world_scene = preload("res://scenes/world.tscn")
var list_class_boxes : Array = []

@onready var grid_container: GridContainer = $CanvasLayer/Control/VBoxContainer/Panel/VScrollBar/ClassContainer
@onready var stats: Label = $CanvasLayer/Control/VBoxContainer/Panel/NinePatchRect/VBoxContainer/Stats

func _ready() -> void:
	for character in GameData.list_available_characters:
		var class_box_instance = class_box_scene.instantiate()
		list_class_boxes.append(class_box_instance)
		class_box_instance.player_stats = character
		class_box_instance.connect("on_class_selected", select_class)
		grid_container.add_child(class_box_instance)
		
	pass # Replace with function body.

func select_class(box : ClassBox) -> void:
	if selected_class_box != null:
		selected_class_box.deselect()
	selected_class_box = box
	selected_class = box.player_stats
	change_stat_display()
	selected_class_box.select()

func change_stat_display() -> void:
	stats.text = "Health: " + str(selected_class.health) + "\n" + \
	"Speed: " + str(selected_class.critical_damage) + "\n" + \
	"Critical chance: " + str(selected_class.critical_chance) + "\n" + \
	"Critical damage: " + str(selected_class.critical_damage) + "\n"
	

func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	PlayerData.player_stats = selected_class
	SceneManagerGlobal.change_scene_to_packed(world_scene)
	# get_tree().change_scene_to_packed(world_scene)

	pass # Replace with function body.

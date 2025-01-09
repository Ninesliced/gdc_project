extends CanvasLayer
class_name RetryUI
@onready var stats_container: VBoxContainer = $Control/HBoxContainer/VBoxContainer/NinePatchRect/ContentContainer/StatsContainer
@export var stats_scene = preload("res://ui/name_value_ui.tscn")

var stats_list : Array[NameValueUI] = []
# Called when the node enters the scene tree for the first time.
func _ready():
	UiGlobal.retry_node = self
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_retry():
	set_stats()
	show()
	pass

func set_stats():
	for stat in stats_list:
		if is_instance_valid(stat):
			stat.queue_free()
	stats_list.clear()
	var stats = PlayerData.player_stats.counter_data.get_stats()
	for stat in stats:
		var name_value_ui_instance : NameValueUI = stats_scene.instantiate()
		name_value_ui_instance.set_name_value(stat, str(stats[stat]))
		stats_list.append(name_value_ui_instance)
		stats_container.add_child(name_value_ui_instance)
	pass
extends CanvasLayer
class_name RetryUI
@onready var stats_container: VBoxContainer = $Control/HBoxContainer/VBoxContainer/NinePatchRect/ContentContainer/StatsContainer
@export var stats_scene = preload("res://ui/name_value_ui.tscn")
@export var enemy_spawner : EnemySpawner = null

var stats_list : Array[NameValueUI] = []
var total_cycle : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	UiGlobal.retry_node = self
	hide()

	if enemy_spawner == null:
		assert(false, "Enemy spawner not set in export variable")
	enemy_spawner.connect("cycle_changed", add_cycle)
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
		add_stat(stat, str(stats[stat]))
	
	add_stat("total cycle", str(total_cycle))
	
	pass

func add_stat(name: String, value: String):
	var name_value_ui_instance : NameValueUI = stats_scene.instantiate()
	name_value_ui_instance.set_name_value(name, value)
	stats_list.append(name_value_ui_instance)
	stats_container.add_child(name_value_ui_instance)
	pass

func add_cycle(cycle: int):
	print("Cycle added")
	total_cycle += 1

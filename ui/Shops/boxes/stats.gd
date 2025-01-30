extends MarginContainer
class_name StatsUI

@onready var stats_container: VBoxContainer = $MarginContainer/StatsContainer
var stats_list : Array[NameValueUI] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func is_empty() -> bool:
	return stats_list.size() == 0

func set_stats(stats: Dictionary) -> void:
	var new_stats : Array[NameValueUI] = UiGlobal.get_ui_stats_from_dict(stats)
	for stat_ui in stats_list:
		if is_instance_valid(stat_ui):
			stat_ui.queue_free()
	stats_list.clear()

	for stat in new_stats:
		stats_container.add_child(stat)
		stats_list.append(stat)

func set_stats_by_resource(resource : Resource) -> void:
	if resource is WeaponProperty:
		set_stats_weapon(resource as WeaponProperty)

func clear_stats() -> void:
	for stat_ui in stats_list:
		if is_instance_valid(stat_ui):
			stat_ui.queue_free()
	stats_list.clear()

func set_stats_weapon(weapon_property : WeaponProperty) -> void:
	var dps = 0
	if weapon_property.fire_rate > 0:
		dps = weapon_property.get_dps()

	var stats = {
		"dps" : dps,
		"damage" : weapon_property.get_damage(),
		"fire_rate" : weapon_property.fire_rate,
		"critical_chance" : str(weapon_property.get_critical_chance() * 100) + "%",
		"critical_damage" : str(weapon_property.get_critical_damage() * 100) + "%",
	}
	set_stats(stats)

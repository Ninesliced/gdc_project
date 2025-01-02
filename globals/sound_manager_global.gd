extends Node

var sound_manager_scene = preload("res://globals/music_manager/SoundManager.tscn")

var sound_manager_instance : Node = null
func _ready() -> void:
	sound_manager_instance = sound_manager_scene.instantiate()
	add_child(sound_manager_instance)
	set_low_pass_filter("Music", true)
	pass


func set_low_pass_filter(bus_name : String, enabled : bool) -> void:
	var audio_bus = AudioServer.get_bus_index("Music")

	if audio_bus != -1:
		for i in range(0, AudioServer.get_bus_effect_count(audio_bus)):
			if AudioServer.get_bus_effect(audio_bus, i) is AudioEffectLowPassFilter:
				AudioServer.set_bus_effect_enabled(audio_bus, i, enabled)
				return
		pass
	pass
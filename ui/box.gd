extends Button
class_name UiBox
var rarity_colors : Dictionary = {
	0: Color(1, 1, 1, 1),
	1 : Color.html("#488bd4"),
	2 : Color.html("#3dff6e"),
	3 : Color.html("#d61a88"),
	4 : Color.html("#ffb84a"),
}

@onready var animation_player : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	play_animation_selected()


func _on_mouse_exited() -> void:
	play_animation_selected(true)
	pass # Replace with function body.

func play_animation_selected(revert = false) -> void:
	if animation_player.is_playing() and animation_player.current_animation != "select_2":
		await animation_player.animation_finished
	if revert:
		$AnimationPlayer.play_backwards("select_2")
	else:
		$AnimationPlayer.play("select_2")


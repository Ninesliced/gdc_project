extends CanvasLayer
class_name Pause
var paused_by_pause_menu := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	print("Pause menu ready x")
	#$HBoxContainer/Continue.grab_focus()
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			get_tree().paused = true
			visible = true
			$Pause/HBoxContainer/Continue.grab_focus()
		else:
			get_tree().paused = false
			visible = false


func _on_continue_pressed() -> void:
	if get_tree().paused == true:
		get_tree().paused = false
		visible = false
	else:
		assert(false, "Pause menu is not visible, but continue button is pressed.")
	pass # Replace with function body.

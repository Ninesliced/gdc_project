extends NinePatchRect
class_name NameValueUI
@onready var text: Label = $HBoxContainer/NinePatchRect2/Text
@onready var value_label: Label = $HBoxContainer/NinePatchRect/Value
var text_string : String = ""
var value_string : String = ""

var value_color = null
var text_color = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if text == null:
		return
	text.text = text_string
	value_label.text = value_string

	if value_color != null:
		value_label.add_theme_color_override("font_color", value_color)
	if text_color != null:
		text.add_theme_color_override("font_color", text_color)

	$AnimationPlayer.play("move_text")

	pass # Replace with function body.

func set_name_value(name : String, value : String):
	print(name + " " + value)
	if is_node_ready():
		text.text = name
		value_label.text = value
	else:
		text_string = name
		value_string = value
	pass

func set_ui(name : String, value : String, parent : Node):
	set_name_value(name, value)
	parent.add_child(self)
	pass

func set_value_color(color : Color):
	if is_node_ready():
		value_label.add_theme_color_override("font_color", color)
	else:
		value_color = color
	pass

func set_text_color(color : Color):
	if is_node_ready():
		text.add_theme_color_override("font_color", color)
	else:
		text_color = color
	pass
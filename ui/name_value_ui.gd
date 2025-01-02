extends NinePatchRect
class_name NameValueUI
@onready var text: RichTextLabel = $HBoxContainer/NinePatchRect2/Text
@onready var value_label: RichTextLabel = $HBoxContainer/NinePatchRect/Value

var text_string : String = ""
var value_string : String = ""

var value_color = null
var text_color = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if text == null:
		return
	$AnimationPlayer.play("move_text")

	pass # Replace with function body.

func set_name_value(name : String, value : String):
	name = "[center][tornado radius=1 freq=1]" + name + "[/tornado][/center]"
	value = "[center][tornado radius=1 freq=1]" + value + "[/tornado][/center]"
	if (!is_node_ready()):
		await ready
	text.text = name
	value_label.text = value
	pass

func set_value_color(color : Color):
	if (!is_node_ready()):
		await ready
	value_label.text = "[color=" + color.to_html() + "]" + value_label.text + "[/color]"
	#value_label.add_theme_color_override("font_color", color)
	pass

func set_text_color(color : Color):
	if (!is_node_ready()):
		await ready
	text.text = "[center][color=" + color.to_html() + "]" + text.text + "[/color][/center]"
	#text.add_theme_color_override("font_color", color)
	pass


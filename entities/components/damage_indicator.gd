extends Node2D
class_name DamageIndicator

var damage: float = 0.0
@export var damage_indicator_duration = 0.5
var damage_timer : Timer = Timer.new()

@export var damage_color_list : Array[Color] = []
@export var damage_number_list : Array[int] = []

@onready var damage_label : Label = $Label
var damage_indicator_timer : Timer = Timer.new()

var init_position : Vector2 = Vector2(0, 0)

func _ready() -> void:
    damage_timer.one_shot = true
    damage_timer.wait_time = damage_indicator_duration
    add_child(damage_timer)
    damage_timer.timeout.connect(_on_damage_indicator_timeout)
    damage_timer.start()
    init_position = global_position

    pass # Replace with function body.

func _process(delta: float) -> void:
    var x = randi_range(-1, 1)
    var y = randi_range(-1, 1)
    global_position = init_position + Vector2(x, y)
    pass


func _on_damage_indicator_timeout() -> void:
    queue_free()
    pass

func set_damage(new_damage: float, is_critical_hit = false) -> void:
    damage_label.text = str(new_damage)
    var index_color = 0

    for i in range(damage_number_list.size() - 1):
        if new_damage < damage_number_list[i + 1]:
            break
        index_color += 1

    damage_label.modulate = damage_color_list[index_color]
    if is_critical_hit:
        var current_size = damage_label.get_theme_font_size("font_size")
        var new_size = current_size * 1.3
        damage_label.text += "𐓷"
        damage_label.add_theme_font_size_override("font_size", new_size)
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.

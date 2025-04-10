extends Node
class_name FloatComponent
var floaty_weapon : bool = false
var relative_position = Vector2(0, 0)
var tped = false
var  object_parent : Node2D = null
var target : Node2D = null
var float_distance : float = 10
func _ready() -> void:
    object_parent = get_parent()

func _process(delta: float) -> void:
    handle_floaty_weapon(delta)

func handle_floaty_weapon(delta: float) -> void:

    if !floaty_weapon:
        return
    if target == null or !is_instance_valid(target):
        return
    if floaty_weapon:
        var direction = target.global_position - object_parent.global_position
        var distance = direction.length()

        object_parent.global_position = object_parent.global_position.move_toward(target.global_position, distance * 12 * delta)
        
        if distance > float_distance:
            var distance_correction = distance - float_distance
            var vector = direction.normalized() * distance_correction
            object_parent.global_position += vector



func set_floaty(floaty: bool, new_relative_position, new_float_distance, new_target : Node2D) -> void:
    target = new_target
    float_distance = new_float_distance
    relative_position = new_relative_position
    floaty_weapon = floaty
    tped = false
    object_parent.top_level = floaty
    object_parent.global_position = target.global_position + relative_position

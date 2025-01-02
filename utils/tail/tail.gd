extends Node2D

@export var point_number : int = 10
@export var parent_instance : Node2D = null
@export var tail_sprite : Texture2D = null
@export var tail_collision : Shape2D = null

var queue : Array = []
var global_position_queue : Array = []

func _ready() -> void:
    for i in range(point_number):
        var sprite = Sprite2D.new()
        sprite.texture = tail_sprite
        sprite.z_index = -1
        var collision = CollisionShape2D.new()
        collision.shape = tail_collision
        collision.z_index = -1
        parent_instance.add_child(sprite)
        parent_instance.add_child(collision)
        queue.append([sprite, collision])
        global_position_queue.append(parent_instance.global_position)


func _process(delta: float) -> void:
    var pos = parent_instance.global_position
    global_position_queue.push_front(pos)
    if global_position_queue.size() > point_number:
        global_position_queue.pop_back()
    for i in range(queue.size()):
        queue[i][0].global_position = global_position_queue[i]
        queue[i][1].global_position = global_position_queue[i]

    pass
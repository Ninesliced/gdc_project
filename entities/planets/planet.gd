extends Node2D

@onready var ui = $ui
var can_interact = false

func _on_area_2d_body_entered(body:Node2D) -> void:
    if body is Player:
        ui.show()
        can_interact = true
    pass


func _on_area_2d_body_exited(body:Node2D) -> void:
    if body is Player:
        ui.hide()
        can_interact = false
    pass # Replace with function body.

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("interact"):
        ShopData.open_shop()
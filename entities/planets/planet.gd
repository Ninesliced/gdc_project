extends Node2D

@onready var ui = $ui

func _on_area_2d_body_entered(body:Node2D) -> void:
    if body is Player:
        ui.show()
    pass


func _on_area_2d_body_exited(body:Node2D) -> void:
    if body is Player:
        ui.hide()
    pass # Replace with function body.

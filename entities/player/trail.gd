extends CPUParticles2D

@export var parent : Node2D = null

func _process(delta: float) -> void:
    angle_min = -rad_to_deg(parent.global_rotation)
    angle_max = angle_min
    
func set_trail_color(color: Color) -> void:
    material.set("shader_parameter/flash_color", color)

func set_trail_texture(texture: Texture) -> void:
    texture = texture
    pass
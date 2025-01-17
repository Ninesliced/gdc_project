extends StaticBody2D

class_name Shield

@onready var collisionBox : CollisionShape2D = $CollisionShape2D
@onready var shieldTexture : Sprite2D = $Shield
@onready var reloadDelayTimer : Timer = $ReloadDelay
@onready var regenTimer : Timer = $RegenTimer
@onready var health_component: HealthComponent = $HealthComponent
@export var shield_property: ShieldProperty = null

func load_resource(resource : Resource) -> void:
	if resource is ShieldProperty:
		shield_property = resource
		reloadDelayTimer.wait_time = shield_property.regeneration_delay
		regenTimer.wait_time = shield_property.regeneration_rate_s
		$Generator.texture = shield_property.generatorTexture
		$Shield.texture = shield_property.shieldTexture
		health_component.hp = shield_property.max_health
		health_component.max_hp = shield_property.max_health
		health_component.initial_hp = shield_property.max_health
		shieldTexture.scale.x *= shield_property.shield_scale
		collisionBox.global_scale.y *= shield_property.shield_scale
	else:
		assert(false, "Invalid resource type")

func _ready() -> void:
	if not shield_property:
		return
	
	load_resource(shield_property)


func _on_health_component_on_damage(damage: int) -> void:
	reloadDelayTimer.start()
	regenTimer.stop()


func _on_health_component_on_death() -> void:
	collision_layer = 0
	shieldTexture.visible = false


func _on_reload_delay_timeout() -> void:
	regenTimer.start()


func _on_regeneration_timer_timeout() -> void:
	regenTimer.start()
	health_component.heal(shield_property.regeneration)
	collision_layer = 1
	shieldTexture.visible = true

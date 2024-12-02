extends Area2D
class_name HitboxComponent


@export var health_component: HealthComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func damage(attack: Attack) -> void:
	if health_component:
		health_component.damage(attack)
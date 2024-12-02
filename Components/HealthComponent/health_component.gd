extends Node2D
class_name HealthComponent


@export var max_health: int
var health: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health


func damage(attack: Attack) -> void:
	health -= attack.attack_damage
	# TODO: This could be replaced by a signal that we emit, so other objects can know when this object dies
	if health <= 0:
		get_parent().queue_free()
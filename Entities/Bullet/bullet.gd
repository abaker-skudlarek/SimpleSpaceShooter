extends Area2D


var speed: int = 1500
var time_to_live: int = 2
var attack_damage: int = 1

func _ready() -> void:
	# Delte self after time to live is up
	get_tree().create_timer(time_to_live).timeout.connect(queue_free) 


func _physics_process(delta: float) -> void:
	position += -transform.y * speed * delta


func _on_area_entered(area:Area2D) -> void:
	if area is HitboxComponent:
		var attack := Attack.new()
		attack.attack_damage = attack_damage
		area.damage(attack)
	# Delete bullet when it hits something with a hitbox
	queue_free()

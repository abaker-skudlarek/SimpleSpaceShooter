extends RigidBody2D

const MAX_SPEED:int = 350

@export var bullet_scene: PackedScene
var forward_thrust := Vector2(0, -150)
var backward_thrust := Vector2(0, 100)
var torque: int = 750
var rng := RandomNumberGenerator.new()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		var newBullet: Node = bullet_scene.instantiate()
		owner.add_child(newBullet)
		newBullet.transform = $BulletSpawnPoint.global_transform


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Limit overall velocity
	if state.linear_velocity.length() > MAX_SPEED:
		state.linear_velocity = state.linear_velocity.normalized() * MAX_SPEED
	
	# Acceleration
	if Input.is_action_pressed("accelerate"):
		state.apply_force(forward_thrust.rotated(rotation))
		animate_thrust()
	elif Input.is_action_pressed("decelerate"):
		state.apply_force(backward_thrust.rotated(rotation))
	else:
		$ThrustSprite.visible = false
		state.apply_force(Vector2())

	# Rotation
	var rotation_direction: int = 0
	if Input.is_action_pressed("rotate_right"):
		rotation_direction += 1
	if Input.is_action_pressed("rotate_left"):
		rotation_direction -= 1
	state.apply_torque(rotation_direction * torque)

	# TODO: This works, but is it the best way to do it? Idk
	if Input.is_action_pressed("brakes"):
		linear_damp = 0.7
		if abs(linear_velocity) <= Vector2(10, 10):
			state.linear_velocity = Vector2.ZERO
	else:
		linear_damp = 0


func animate_thrust() -> void:
	# Turn the thrust sprite on and off randomly
	# TODO: this would probably be much better as an animation?
	var choices := [0, 1, 2, 3]
	if choices[randi() % choices.size()] != 0:
		$ThrustSprite.visible = true
	else:
		$ThrustSprite.visible = false

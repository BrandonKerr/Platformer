extends Actor

# pixels/second impulse to apply when stomping an enemy
export var stomp_impulse: = 1000.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	# make the user bounce up when stomping the enemy
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

# when an enemy body enters the EnemyDetector, then they hit the player
func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	# kill the player
	die()
	

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	
	# update the _velocity using the result of move_and_slide so that it handles collisions, etc
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	

func get_direction() -> Vector2:
	return Vector2(
		# get strength of the action as a float 0.0-1.0
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		# get the -ve value of the jump action strength (because our origin is in the top-left) if the player can jump, otherwise set it to 0
		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	)

func calculate_move_velocity(
	linear_velocity: Vector2,
	 direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
	) -> Vector2:
	var out = linear_velocity
	out.x = speed.x * direction.x
	# use get_physics_process_delta_time() to get the delta (rather than passing more params)
	out.y += gravity * get_physics_process_delta_time()
	# if the user is jumping, adjust the y output
	if direction.y == -1.0:
		out.y = speed.y * direction.y
		# play the sound effect
		$JumpSound.play()
	# allow for an interruption so that the player can release the jump button to have a shorter jump
	if is_jump_interrupted:
		out.y = 0.0
	
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float)-> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

func die() -> void:
	# TODO: play death sound
	PlayerData.deaths += 1
	queue_free()


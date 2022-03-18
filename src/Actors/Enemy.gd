extends "res://src/Actors/Actor.gd"

export var score:= 100

func _ready() -> void:
	# deactivate the enemy by default so that they only process when visible
	set_physics_process(false)
	_velocity.x = -speed.x

func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	# if the body (player) enters from below the stomp detector, do nothing
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	# if we're here, then the player entered from above and has hit the enemy, so kill it
	# disable the collision first to make sure the player can't die when killing the enemy
	die()

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	# if the enemy hits a wall, turn it around
	if is_on_wall():
		_velocity.x *= -1.0
	# only set the y coordinate because the collision will reset the x to 0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die() -> void:
	get_node("CollisionShape2D").disabled = true
	queue_free()
	PlayerData.score += score

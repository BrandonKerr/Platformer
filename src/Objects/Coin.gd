extends Area2D

export var score:= 100

# onready is "syntactic sugar" to assign a value to a variable as if it were done in _ready
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

# when the coin's body is entered (by the player), play the fade out animation
func _on_body_entered(body: PhysicsBody2D) -> void:
	PlayerData.score += score
	anim_player.play("fade_out")

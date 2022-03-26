tool
extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer
export var next_scene: PackedScene

func _on_body_entered(body: PhysicsBody2D) -> void:
	teleport(body)

func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""

func teleport(body: PhysicsBody2D) -> void:
	# disable the player so they don't keep moving
	body.set_physics_process(false)
	PlayerData.addLevelScore()
	$EnterSound.play()
	anim_player.play("fade_to_black")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)


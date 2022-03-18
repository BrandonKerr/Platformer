extends KinematicBody2D
class_name Actor

# move_and_slide needs to know what the floor's normal is (in a side-scroller like this, it's UP
const FLOOR_NORMAL = Vector2.UP

export var speed:= Vector2(300.0, 1000.0)
export var gravity: = 3000.0
var _velocity: = Vector2.ZERO

# use _physics_process instead of _process because we have physics acting on these nodes
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	

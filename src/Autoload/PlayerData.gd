extends Node

signal score_updated
signal player_died

# TODO level_score so that we add it to score when completing the level and reset to 0 on death or retry
var score: = 0 setget set_score
var deaths: = 0 setget set_deaths

var is_input_disabled:= false

func reset() -> void:
	score = 0
	deaths = 0

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")

func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")

func set_is_input_disabled(value: bool) -> void:
	is_input_disabled = value

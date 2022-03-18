extends Control

onready var label: Label = $Label

func _ready() -> void:
	$Menu/PlayButton.grab_focus()
	label.text = label.text % [PlayerData.score, PlayerData.deaths]

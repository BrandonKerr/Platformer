extends Control

func _ready() -> void:
	$Menu/PlayButton.grab_focus()
	# reset the player's score and death in case they're retrying
	PlayerData.reset()
	

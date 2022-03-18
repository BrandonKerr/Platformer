tool
extends Button

export(String, FILE) var next_scene_path = ""

func _on_button_up() -> void:
	# in case the player paused the game, make sure the game isn't paused when going to the next scene
	get_tree().paused = false
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "next_scen_path must be set" if next_scene_path == "" else ""

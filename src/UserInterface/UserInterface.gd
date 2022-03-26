extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = $PauseOverlay
onready var death_overlay: ColorRect = $DeathOverlay
onready var score_label: Label = $ScoreLabel

var paused: = false setget set_paused

func _ready() -> void:
	# connect the score_updated signal from PlayerData to our update_interface function (same sort of thing that would be done in the node menu
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	update_interface()

func _on_PlayerData_player_died() -> void:
	scene_tree.paused = true
	death_overlay.visible = true
	$DeathOverlay/Menu/RetryButton.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("pause") && !death_overlay.visible):
		# make sure to use SELF so that it will go through the setter function
		self.paused = !paused
		scene_tree.set_input_as_handled()

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
	if paused == true:
		$PauseOverlay/Menu/ResumeButton.grab_focus()

func update_interface() -> void:
	score_label.text = "Score: %s" % (PlayerData.score + PlayerData.total_score)


func _on_ResumeButton_button_up() -> void:
	self.paused = false

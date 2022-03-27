extends Node

var main_music = load("res://assets/audio/bgm/main.wav")

func play_main_music() -> void:
	# make sure we don't restart every time
	if !$Music.playing :
		$Music.stream = main_music
		$Music.play()

func stop_music() -> void:
	$Music.stop()

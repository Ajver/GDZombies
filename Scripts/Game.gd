extends Node2D

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

func _on_ThemeMusic_finished():
	$ThemeMusic.play()

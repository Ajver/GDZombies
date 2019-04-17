extends Node2D

export(float) var fading_time = 0.5

var timer : float = 0.0
var is_fading = false

var is_fading_in = false

func _process(delta):
	if not is_fading:
		return
	
	timer += delta
	
	if timer >= fading_time:
		is_fading = false
		
		if is_fading_in:
			set_opacity(1.0)
			$VisibilityTimer.start()
		else:
			set_opacity(0.0)
	
	else:
		if is_fading_in:
			set_opacity(timer / fading_time)
		else:
			set_opacity(1.0 - (timer / fading_time))
		
	
func fade_in():
	timer = 0.0
	visible = true
	is_fading = true
	is_fading_in = true
	
func fade_out():
	timer = 0.0
	is_fading = true
	is_fading_in = false

func _on_VisibilityTimer_timeout():
	fade_out()

func set_opacity(alpha):
	$Sprite.modulate = Color(1.0, 1.0, 1.0, alpha)

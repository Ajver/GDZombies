extends ParallaxBackground

export(float) var fading_time = 0.5

var timer : float = 0.0
var is_fading = false

var is_fading_in = false

var current_sprite : Sprite = null

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
			current_sprite.visible = false
	
	else:
		if is_fading_in:
			set_opacity(timer / fading_time)
		else:
			set_opacity(1.0 - (timer / fading_time))
	
func fade_in():
	timer = 0.0
	current_sprite.visible = true
	is_fading = true
	is_fading_in = true
	
func fade_out():
	timer = 0.0
	is_fading = true
	is_fading_in = false

func _on_VisibilityTimer_timeout():
	fade_out()

func set_opacity(alpha):
	current_sprite.modulate = Color(1.0, 1.0, 1.0, alpha)

func _on_Player_double_kill():
	fade($ParallaxLayer/DoubleKill)

func _on_Player_multi_kill():
	# TODO - add multikill sprite
	fade($ParallaxLayer/DoubleKill)

func fade(sprite):
	current_sprite = sprite
	fade_in()

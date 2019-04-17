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
			set_scale(1.0)
			$VisibilityTimer.start()
			$PunchSound.play()
		else:
			current_sprite.visible = false
	
	else:
		set_opacity(get_progress())
		set_scale(1.0 + get_inv_progress() * 4.0)
	
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

func set_scale(s):
	current_sprite.scale.x = s
	current_sprite.scale.y = s

func _on_Player_double_kill():
	fade($ParallaxLayer/DoubleKill)

func _on_Player_multi_kill():
	fade($ParallaxLayer/MultiKill)

func fade(sprite):
	current_sprite = sprite
	fade_in()

func get_progress():
	if is_fading_in:
		return timer / fading_time
	else:
		return 1.0 - (timer / fading_time)
		
func get_inv_progress():
	if is_fading_in:
		return 1.0 - (timer / fading_time)
	else:
		return timer / fading_time
	
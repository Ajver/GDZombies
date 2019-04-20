extends CanvasLayer

func _ready():
	var screen_size = get_viewport().size
	var pos = screen_size * 0.5
	
	pos.y *= 0.5
	
	$DoubleKill.position = pos
	$MultiKill.position = pos

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		$DoubleKill.start_anim()

func _on_Player_double_kill():
	$DoubleKill.start_anim()

func _on_Player_multi_kill():
	$MultiKill.start_anim()

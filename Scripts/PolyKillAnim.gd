extends Sprite

func start_anim():
	$AnimationPlayer.play("show")
	$PunchSound.play()
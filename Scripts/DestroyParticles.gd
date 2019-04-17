extends Particles2D


func _on_Zombie_died(bullet):
	position = position.rotated(bullet.rotation)
	rotation = bullet.rotation
	emitting = true
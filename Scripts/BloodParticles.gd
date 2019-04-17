extends Particles2D

onready var default_pos = position
onready var max_amount = amount * 2


func _on_Zombie_bullet_hit(bullet):
	amount = (bullet.damage / bullet.max_damage) * max_amount
	position = default_pos.rotated(bullet.rotation)
	rotation = bullet.rotation
	emitting = true

extends Area2D

signal double_kill()
signal multi_kill()

export(float) var speed = 1200
export(float) var strange = 30
export(float) var delta_strange = 30

var velocity : Vector2
var Zombie = load("res://Scripts/Zombie.gd")
var Player = load("res://Scripts/Player.gd")

var damage
var max_damage = strange+delta_strange

var killed_zombies : int = 0

func _ready():
	damage = strange + randf() * delta_strange

func _process(delta):
	position += velocity * delta

func set_direction(dir):
	velocity = dir * speed
	rotation = dir.angle()

func _on_Bullet_body_entered(body):
	if body.name == "Player":
		return

	if body is Zombie:
		body.hit(self)
		if body.is_alive:
			die()
		else:
			damage -= 5
			killed_zombies += 1
			if killed_zombies >= 3:
				die()
	elif body.name == "Walls":
		var DestroyedBullet = load("res://Scenes/DestroyedBullet.tscn")
		var db = DestroyedBullet.instance()
		get_parent().add_child(db)
		db.position = self.global_position
		die()
	
func die():
	emit_polykill_signal()
	queue_free()
	
func emit_polykill_signal():
	if killed_zombies <= 1:
		return
	 
	if killed_zombies == 2:
		emit_signal("double_kill")
	else:
		emit_signal("multi_kill")

	
extends Node2D

export(int) var count

var Zombie = load("res://Scenes/Zombie.tscn")

func _ready():
	for i in range(count):
		var z = Zombie.instance()
		push_next(z)
		z.set_collision(false)
		z.zombies_pool = self
		
func push_next(z):
	add_child(z)
	z.disable_self()
	
func pop_next(next_zombie_position : Vector2 = Vector2(0, 0)):
	var next = get_children()[get_child_count()-1]
	next.position = next_zombie_position
	next.enable_self()
	remove_child(next)
	return next
		
func has_next():
	return get_child_count() > 0
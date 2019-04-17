extends Node2D

export(float) var delta_wait_time = 0.2

onready var map = get_parent().get_parent()
onready var zombie_pool = get_tree().get_root().get_node("Game/ZombiesPool")

var Zombie = load("res://Scenes/Zombie.tscn")

func _on_NextZombieTimer_timeout():
	if not zombie_pool.has_next():
		return
		
	var z = zombie_pool.pop_next(self.position)
	map.add_child(z)
	
	$NextZombieTimer.wait_time += (randf() - 0.5) * delta_wait_time  
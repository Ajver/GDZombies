extends Node2D

onready var map = get_parent().get_parent()
onready var player = map.get_node("Player")

export(float) var delta_wait_time = 1.0

var items = [
	load("res://Scenes/AmmoItem.tscn"),
	load("res://Scenes/HealthItem.tscn")
]

func _on_NextItemTimer_timeout():
	var item_nr = randi() % items.size()
	var item = items[item_nr].instance()
	
	map.add_child(item)
	
	item.position = self.position
	item.connect("pickup", self, "_on_Item_pickup")
	
func _on_Item_pickup():
	$NextItemTimer.wait_time += (randf()-0.5) * delta_wait_time
	$NextItemTimer.start()

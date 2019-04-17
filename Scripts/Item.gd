extends Area2D

signal pickup()

onready var Player = load("res://Scripts/Player.gd") 

func _on_Item_body_entered(body):
	if not visible:
		return 
		
	$PickupSound.play()
	emit_signal("pickup")
	hide()
	

func _on_PickupSound_finished():
	queue_free()

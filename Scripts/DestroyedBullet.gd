extends Node2D

func _ready():
	$Particles.emitting = true

func _on_LifeTimer_timeout():
	queue_free()

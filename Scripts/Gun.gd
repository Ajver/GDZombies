extends Node2D

onready var Bullet = load("res://Scenes/Bullet.tscn")
onready var player = get_parent()

var can_shot : bool = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("game_shot"):
		if not can_shot:
			return
			
		shot()

func shot():
	create_bullet()
	
	player.get_node("Camera2D").start_shake()
	
	can_shot = false
	$NextShotTimer.start()
	$ShotSound.play()
	$ShotParticles.emitting = true
	
func create_bullet():
	var b = Bullet.instance()
	player.get_parent().add_child(b)
	
	var dir = get_direction()
	b.set_direction(dir)
	b.position = self.global_position
	
	b.connect("double_kill", player, "_on_Bullet_double_kill")
	b.connect("multi_kill", player, "_on_Bullet_multi_kill")
		
func get_direction():
	var mouse_pos = get_viewport().get_mouse_position()
	var diff = mouse_pos - get_viewport_rect().size * 0.5 - self.position * 0.5
	return diff.normalized()

func _on_NextShotTimer_timeout():
	can_shot = true

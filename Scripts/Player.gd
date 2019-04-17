extends KinematicBody2D

export(float) var speed = 400

var velocity : Vector2 = Vector2(0, 0)

func _ready():
	set_process_input(true)

func _physics_process(delta):
	move_and_slide(velocity)

func _input(event):
	set_velocity_from_input()
	set_rotation_from_mouse(event)
	
func set_velocity_from_input():
	velocity = Vector2(0, 0)
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	velocity = velocity.normalized() * speed
	
func set_rotation_from_mouse(event):
	var mouse_pos = get_viewport().get_mouse_position()
	
	var diff = mouse_pos - get_viewport_rect().size * 0.5
	var angle = diff.angle()
	
	self.rotation = angle

func _on_Bullet_double_kill():
	
	pass
	
func _on_Bullet_multi_kill():
	pass
	
	
	
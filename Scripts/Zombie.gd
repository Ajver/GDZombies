extends KinematicBody2D

signal health_changed(health)
signal bullet_hit(bullet)
signal died(bullet)

export(float) var speed = 150
export(float) var max_hp = 100
export(float) var bounce_range = 1.0

onready var target = get_tree().get_root().get_node("Game/Map/Player")

var zombies_pool

var hp : float = max_hp
var is_alive : bool = true

onready var sounds = [
	$ZombieSounds/ZombieSound1,
	$ZombieSounds/ZombieSound2,
	$ZombieSounds/ZombieSound3,
	$ZombieSounds/ZombieSound4
]

func disable_self():
	setup(false)
	$NextSoundTimer.stop()
	
func enable_self():
	setup(true)
	set_collision(true)
	$NextSoundTimer.wait_time = randf() * 4
	$NextSoundTimer.start()
	hp = max_hp
	$HPBar.set_max_value(max_hp)
	$HPBar.set_value(hp)
	
func setup(value):
	is_alive = value
	set_physics_process(value)
	
func set_collision(value):
	collision_layer = int(value)
	collision_mask = int(value)
	
func _physics_process(delta):
	if not is_alive:
		return
		
	var vel = get_velocity_to_target()
	go_to_target(vel)
	set_rotation_from_vel(vel)
	
func go_to_target(vel):
	move_and_slide(vel)
	
func get_velocity_to_target():
	var diff = target.position - self.position
	return diff.normalized() * speed
	
func set_rotation_from_vel(vel):
	var angle = vel.angle()
	$Sprite.rotation = angle - deg2rad(90)
	
func hit(bullet):
	position += bullet.velocity.normalized() * bullet.damage * bounce_range
	hp -= bullet.damage
		
	if hp <= 0: die(bullet)
	
	emit_signal("bullet_hit", bullet)
	emit_signal("health_changed", hp)
	
func die(bullet):
	hp = 0
	$VanishTimer.start()
	is_alive = false
	set_collision(false)
	get_parent().move_child(self, 1)
	emit_signal("died", bullet)

func _on_VanishTimer_timeout():
	get_parent().remove_child(self)
	zombies_pool.push_next(self)

func _on_NextSoundTimer_timeout():
	var sound_nr = randi() % sounds.size()
	var sound = sounds[sound_nr]
	sound.play()
	
	set_random_sound_time()
	
func set_random_sound_time():
	$NextSoundTimer.wait_time = 8 + randi() % 8	

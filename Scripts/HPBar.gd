extends Node2D

var is_bg_changing : bool = false
var health : float

func _process(delta):		
	if is_bg_changing:
		$HPBackground.value = lerp($HPBackground.value, health-0.1, 0.1)
		
func _on_Zombie_health_changed(new_health):
#	$HPBackground.value = $HP.value
	self.health = new_health
	$HP.value = new_health
	is_bg_changing = false
	$HealthBackgroundChange.start()

func set_max_value(max_value):
	$HP.max_value = max_value
	$HPBackground.max_value = max_value
	
func set_value(value):
	self.health = value
	$HP.value = value
	$HPBackground.value = value

func _on_HealthBackgroundChange_timeout():
	is_bg_changing = true

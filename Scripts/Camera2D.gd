extends Camera2D

export(float) var shake_power = 4.0
export(float) var shake_zoom_power = 0.005
export(float) var shake_time = 0.3

var isShake = false
var curPos
var elapsedtime = 0

onready var player = get_parent()

func _ready():
    randomize()
    curPos = offset

func _physics_process(delta):
	if isShake:
		shake(delta) 
	
func start_shake():
	isShake = true
	elapsedtime = 0
	
func shake(delta):
	if elapsedtime < shake_time:
		elapsedtime += delta
		
		var newOffset = Vector2(randf()-0.5, randf()-0.5) * shake_power
		offset = newOffset
		
		var progress = elapsedtime / shake_time
		var new_scale = 1.0 + sin((1.0-progress) * PI * 2) * shake_zoom_power
		zoom.x = new_scale
		zoom.y = new_scale
		
	else:
		isShake = false
		elapsedtime = 0
		offset = curPos     
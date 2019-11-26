extends Node

signal score_changed

var score : int = 0 setget set_score

func set_score(v:int) -> void:
	score = v
	emit_signal("score_changed")

func add_score(v:int) -> void:
	set_score(GameData.score + v)
	
func _on_Zomie_died(bullet) -> void:
	match bullet.killed_zombies:
		0: 
			add_score(1)
		1: 
			add_score(4)
		2: 
			add_score(16)
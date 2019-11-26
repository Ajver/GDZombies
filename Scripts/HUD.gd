extends CanvasLayer

onready var score_label = find_node("ScoreLabel")

func _ready() -> void:
	GameData.connect("score_changed", self, "_on_Score_changed")
	
func _on_Score_changed() -> void:
	score_label.text = str("score ", GameData.score)
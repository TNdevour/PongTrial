class_name Scorer extends Node

var _player_score:int = 0
var _ai_score:int = 0

func _ready() -> void:
	SignalHub.on_ai_scored.connect(on_ai_scored)
	SignalHub.on_player_scored.connect(on_player_scored)

func on_ai_scored()->void:
	_ai_score += 1

func on_player_scored()->void:
	_player_score += 1

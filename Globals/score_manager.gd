extends Node

var player_score:int=0:
	get:
		return player_score

var ai_score:int = 0:
	get:
		return ai_score

var winning_score:int = 10:
	set(value):
		winning_score = value

func _ready() -> void:
	SignalHub.on_ai_scored.connect(on_ai_scored)
	SignalHub.on_player_scored.connect(on_player_scored)
	SignalHub.on_game_restarted.connect(reset_scores)
	print("winning score: %d"%[winning_score])

func on_ai_scored()->void:
	ai_score += 1
	if is_game_over(): SignalHub.emit_on_game_over(false)

func on_player_scored()->void:
	player_score += 1
	if is_game_over(): SignalHub.emit_on_game_over(true)

func reset_scores()-> void:
	player_score = 0
	ai_score = 0
	SignalHub.emit_on_start_round()

func is_game_over()->bool:
	return player_score >= winning_score or ai_score >= winning_score
	

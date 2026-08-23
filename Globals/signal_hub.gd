extends Node

signal on_player_scored
signal on_ai_scored
signal on_ball_spawned(new_ball:Ball)
signal on_start_round

func emit_on_player_scored() -> void:
	on_player_scored.emit()

func emit_on_ai_scored()-> void:
	on_ai_scored.emit()

func emit_on_ball_spawned(new_ball:Ball)-> void:
	on_ball_spawned.emit(new_ball)

func emit_on_start_round()-> void:
	on_start_round.emit()

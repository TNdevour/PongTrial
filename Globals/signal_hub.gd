extends Node

signal on_player_scored
signal on_ai_scored
signal on_ball_spawned(new_ball:Ball)
signal on_start_round
signal on_ball_launched
signal on_start_game
signal on_game_over(player_won:bool)
signal on_game_restarted
signal on_ball_bounce
signal on_difficulty_set(new_difficulty:String)

func emit_on_player_scored() -> void:
	on_player_scored.emit()

func emit_on_ai_scored()-> void:
	on_ai_scored.emit()

func emit_on_ball_spawned(new_ball:Ball)-> void:
	on_ball_spawned.emit(new_ball)

func emit_on_start_round()-> void:
	on_start_round.emit()

func emit_on_ball_launched()->void:
	on_ball_launched.emit()

func emit_on_start_game()->void:
	on_start_game.emit()

func emit_on_game_over(player_won:bool)-> void:
	on_game_over.emit(player_won)

func emit_on_game_restarted()-> void:
	on_game_restarted.emit()

func emit_on_ball_bounce()-> void:
	on_ball_bounce.emit()

func emit_on_difficulty_set(new_difficulty:String)-> void:
	on_difficulty_set.emit(new_difficulty)

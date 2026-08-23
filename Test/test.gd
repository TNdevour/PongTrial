extends Node

@onready var launch_timer: Timer = $LaunchTimer
@onready var ball: Ball = $Ball
@onready var player_score_area: Area2D = $PlayerScoreArea
@onready var ai_score_area: Area2D = $AiScoreArea

func _ready() -> void:
	launch_timer.start()

func _on_launch_timer_timeout() -> void:
	ball.launch_ball(ball)

func _on_player_score_area_body_entered(body: Node2D) -> void:
	if body is Ball: SignalHub.emit_on_ai_scored()

func _on_ai_score_area_body_entered(body: Node2D) -> void:
	if body is Ball: SignalHub.emit_on_player_scored()

func spawn_new_ball()-> void:
	pass

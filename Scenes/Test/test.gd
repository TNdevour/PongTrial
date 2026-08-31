extends Node

@onready var launch_timer: Timer = $LaunchTimer
#@onready var ball: Ball = $Ball
@onready var player_score_area: Area2D = $PlayerScoreArea
@onready var ai_score_area: Area2D = $AiScoreArea
@onready var ball_v_2: BallV2 = $BallV2

func _ready() -> void:
	launch_timer.start()

func _on_launch_timer_timeout() -> void:
	#ball.launch_ball()
	ball_v_2.launch_ball()
	pass

func _on_player_score_area_body_entered(body: Node2D) -> void:
	if body is BallV2: SignalHub.emit_on_ai_scored()

func _on_ai_score_area_body_entered(body: Node2D) -> void:
	if body is BallV2: SignalHub.emit_on_player_scored()

func spawn_new_ball()-> void:
	pass

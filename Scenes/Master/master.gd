extends Node

@onready var spawn_point: Marker2D = $SpawnPoint
@onready var player_paddle: AnimatableBody2D = $PlayerPaddle
@onready var ai_paddle: AnimatableBody2D = $AiPaddle
@onready var spawn_timer: Timer = $SpawnTimer
@onready var launch_timer: Timer = $LaunchTimer

@export var _ball_scene: PackedScene

func _ready() -> void:
	SignalHub.on_player_scored.connect(start_new_round)
	SignalHub.on_ai_scored.connect(start_new_round)
	SignalHub.on_start_game.connect(start_new_round)
	SignalHub.on_game_restarted.connect(start_new_round)

func start_new_round()-> void:
	if spawn_timer.is_inside_tree():
		spawn_timer.start()

func spawn_new_ball()-> void:
	var ball:Ball = _ball_scene.instantiate()
	ball.position = spawn_point.position
	add_child(ball)
	SignalHub.emit_on_ball_spawned(ball)
	launch_timer.start()

func _on_player_score_area_body_entered(body: Node2D) -> void:
	if body is Ball: SignalHub.emit_on_ai_scored()

func _on_ai_score_area_body_entered(body: Node2D) -> void:
	if body is Ball: SignalHub.emit_on_player_scored()

func _on_spawn_timer_timeout() -> void:
	spawn_new_ball()

func _on_launch_timer_timeout() -> void:
	SignalHub.emit_on_ball_launched()

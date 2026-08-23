extends Node

@onready var scorer: Scorer = $Scorer
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var player_paddle: AnimatableBody2D = $PlayerPaddle
@onready var ai_paddle: AnimatableBody2D = $AiPaddle
@onready var spawn_timer: Timer = $SpawnTimer

@export var _ball_scene: PackedScene

func _ready() -> void:
	SignalHub.on_player_scored.connect(start_new_round)
	SignalHub.on_ai_scored.connect(start_new_round)
	start_new_round()

func start_new_round()-> void:
	spawn_timer.start()

func spawn_new_ball()-> void:
	var ball:Ball = _ball_scene.instantiate()
	ball.position = spawn_point.position
	add_child(ball)
	SignalHub.emit_on_ball_spawned(ball)

func _on_player_score_area_body_entered(body: Node2D) -> void:
	if body is Ball: SignalHub.emit_on_ai_scored()

func _on_ai_score_area_body_entered(body: Node2D) -> void:
	if body is Ball: SignalHub.emit_on_player_scored()

func _on_spawn_timer_timeout() -> void:
	spawn_new_ball()

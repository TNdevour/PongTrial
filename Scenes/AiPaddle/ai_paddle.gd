extends AnimatableBody2D

@export var _target_ball:Ball
@export var _paddle_speed: float = 220.0
@onready var texture_rect: TextureRect = $TextureRect

const PADDLE_GROUP: String = "paddles"
const PADDLE_BUFFER_DISTANCE: float = 10.0
const HEIGHT_PADDING: float = 20.0
const SPEED_MULTIPLIER: float = 2.0
var _paddle_half_height: float = 0.0
var HARD_MODE: String = "HARD"

var _can_move:bool = true

func _ready() -> void:
	SignalHub.on_ball_spawned.connect(set_up_target_ball)
	add_to_group(PADDLE_GROUP)
	_paddle_half_height = texture_rect.size.x/2 - HEIGHT_PADDING
	set_difficulty_variables()

func _physics_process(_delta: float) -> void:
	if !_can_move: return
	if _target_ball == null:
		_can_move = false
		return
	follow_target_ball()

func set_up_target_ball(new_ball:Ball)-> void:
	_target_ball = new_ball
	_can_move = true

func follow_target_ball()-> void:	
	if _target_ball == null: return
	var direction: float = 0.0
	if _target_ball.position.y > position.y + PADDLE_BUFFER_DISTANCE:
		direction = 1.0
	elif _target_ball.position.y < position.y - PADDLE_BUFFER_DISTANCE:
		direction = -1.0
	var new_pos = position.y +( direction * _paddle_speed * get_physics_process_delta_time())
	new_pos = clamp(
		new_pos, 
		get_viewport_rect().position.y + _paddle_half_height, 
		get_viewport_rect().end.y - _paddle_half_height
		)
	position.y = new_pos

func set_difficulty_variables()-> void:
	var difficulty_id:int = ScoreManager.GameDifficulty.get(HARD_MODE)
	if ScoreManager._game_difficulty == difficulty_id:
		_paddle_speed *= SPEED_MULTIPLIER
		print("AI paddle speed: %d"%[_paddle_speed])
		

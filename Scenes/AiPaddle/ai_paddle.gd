extends AnimatableBody2D

@export var _target_ball:Ball
@export var _speed: float = 200.0

const PADDLE_GROUP: String = "paddles"
const PADDLE_BUFFER_DISTANCE: float = 10.0

var _can_move:bool = true

func _ready() -> void:
	SignalHub.on_ball_spawned.connect(set_up_target_ball)
	add_to_group(PADDLE_GROUP)

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
	position.y += direction * _speed * get_physics_process_delta_time()

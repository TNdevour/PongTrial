##A characterbody2d based implementation of the ball.
##Created to allow easier control over what the ball's movement than the rigidbody2d implementation.

class_name Ball extends CharacterBody2D

var _speed:float = 700.0
var _horizontal_value:float = 0
var _vertical_value:float = 0
var _launch_direction:Vector2 = Vector2.ZERO
var _can_move:bool = false

@onready var collision_timer: Timer = $CollisionTimer
@onready var arrow_pivot: Marker2D = $ArrowPivot
@onready var arrow: Polygon2D = $ArrowPivot/Arrow

const SPEED_MULTIPLIER: float = 1.05
const MAX_X_VALUE: float = 1.0
const MAX_Y_VALUE: float = 0.7
const AIM_FACTOR: float = 10000.0

func _ready() -> void:
	SignalHub.on_ball_spawned.connect(aim_ball)
	SignalHub.on_player_scored.connect(destroy_ball)
	SignalHub.on_ai_scored.connect(destroy_ball)
	SignalHub.on_ball_launched.connect(launch_ball)
	set_new_direction()

func aim_ball(_new_ball:Ball)-> void:
	arrow_pivot.look_at(_launch_direction * AIM_FACTOR)
	arrow_pivot.show()

func launch_ball()-> void:
	_can_move = true
	arrow_pivot.hide()
	arrow.hide()

func set_new_direction()-> void:
	_horizontal_value =  [-MAX_X_VALUE,MAX_X_VALUE].pick_random()
	_vertical_value =  randf_range(-MAX_Y_VALUE,MAX_Y_VALUE)
	_launch_direction = Vector2(_horizontal_value, _vertical_value).normalized()

func _physics_process(delta: float) -> void:
	if !_can_move: return
	
	var collision:= move_and_collide(_launch_direction * delta * _speed)
	if collision and collision_timer.is_stopped():
		SignalHub.emit_on_ball_bounce()
		collision_timer.start()
		_launch_direction = _launch_direction.bounce(collision.get_normal())
		if collision.get_collider().is_in_group("paddles"):
			_speed *= SPEED_MULTIPLIER

func destroy_ball()->void:
	print("BallV2: someone scored")
	queue_free()

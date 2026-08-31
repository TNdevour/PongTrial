##Deprecated: original ball_class implementation
class_name Ball_deprec extends RigidBody2D

const LAUNCH_IMPULSE: float = 1000.0
const MAX_X_VALUE: float = 1.0
const MAX_Y_VALUE: float = 0.7
const SPEED: float = 50.0
const SPEED_MULTIPLIER: float = 1.01
const PADDLE_GROUP: String = "paddles"
const WALL_GROUP:String = "walls"
var _bounce_factor:float

@onready var arrow: Polygon2D = $ArrowPivot/Arrow
@onready var arrow_pivot: Marker2D = $ArrowPivot

var _horizontal_value:float = 0
var _vertical_value:float = 0
var _launch_direction:Vector2 = Vector2.ZERO

func _ready() -> void:
	arrow.hide()
	SignalHub.on_ball_spawned.connect(aim_ball)
	SignalHub.on_player_scored.connect(destroy_ball)
	SignalHub.on_ai_scored.connect(destroy_ball)
	SignalHub.on_ball_launched.connect(launch_ball)
	set_new_direction()
	_bounce_factor = SPEED

func set_new_direction()-> void:
	_horizontal_value =  [-MAX_X_VALUE,MAX_X_VALUE].pick_random()
	_vertical_value =  randf_range(-MAX_Y_VALUE,MAX_Y_VALUE)
	_launch_direction = Vector2(_horizontal_value, _vertical_value).normalized()

func aim_ball(_new_ball: Ball)-> void:
	arrow_pivot.look_at(_launch_direction * LAUNCH_IMPULSE)
	arrow.show()
	
func launch_ball()-> void:
	arrow.hide()
	apply_central_impulse(LAUNCH_IMPULSE * _launch_direction)

func destroy_ball()->void:
	print("someone scored")
	queue_free()

func _on_body_entered(body: Node) -> void:
	SignalHub.emit_on_ball_bounce()
	var direction = Vector2.ZERO
	if body.is_in_group(PADDLE_GROUP):
		direction += Vector2(0,randf_range(-MAX_Y_VALUE,MAX_Y_VALUE)).normalized()
		_bounce_factor *= SPEED_MULTIPLIER
	if body.is_in_group(WALL_GROUP):
		direction += Vector2(randf_range(-MAX_Y_VALUE,MAX_Y_VALUE),0).normalized()
	linear_velocity += direction * _bounce_factor
	

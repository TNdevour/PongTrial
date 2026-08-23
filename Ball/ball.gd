class_name Ball extends RigidBody2D

const LAUNCH_IMPULSE: float = 1000.0
const MAX_X_VALUE: float = 1.0
const MAX_Y_VALUE: float = 0.6
const SPEED: float = 200
const SPEED_MULTIPLIER: float = 1.05
const PADDLE_GROUP: String = "paddles"

func _ready() -> void:
	SignalHub.on_ball_spawned.connect(launch_ball)
	SignalHub.on_player_scored.connect(destroy_ball)
	SignalHub.on_ai_scored.connect(destroy_ball)

func launch_ball(_new_ball:Ball)-> void:
	var horizontal_value:float =  [-MAX_X_VALUE,MAX_X_VALUE].pick_random()
	var vertical_value:float =  randf_range(-MAX_Y_VALUE,MAX_Y_VALUE)
	var launch_direction:Vector2 = Vector2(horizontal_value, vertical_value).normalized()
	print("launch_direction: (%d,%d)"%[horizontal_value, vertical_value])
	print("launch_direction: (%s)"%[launch_direction])
	apply_central_impulse(LAUNCH_IMPULSE * launch_direction)

func destroy_ball()->void:
	print("someone scored")
	queue_free()

func _on_body_entered(body: Node) -> void:
	var direction = Vector2.ZERO
	if body.is_in_group(PADDLE_GROUP):
		print("hit a paddle")
		direction += Vector2(0,randf_range(-0.6,0.6)).normalized()
	linear_velocity += direction

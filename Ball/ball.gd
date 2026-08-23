class_name Ball extends RigidBody2D

const LAUNCH_IMPULSE: float = 1000.0

func launch_ball()-> void:
	var horizontal_value:float =  [-1.0,1.0].pick_random()
	var vertical_value:float =  randf_range(-0.6,0.6)
	var launch_direction:Vector2 = Vector2(horizontal_value, vertical_value).normalized()
	print("launch_direction: (%d,%d)"%[horizontal_value, vertical_value])
	print("launch_direction: (%s)"%[launch_direction])
	apply_central_impulse(LAUNCH_IMPULSE * launch_direction)

func on_enemy_scored()-> void:
	pass

func on_ai_scored()->void:
	pass

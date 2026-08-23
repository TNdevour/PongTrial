extends AnimatableBody2D

@export var _paddle_speed: float = 500.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var move_direction: float = Input.get_axis("move_up","move_down")	
	position.y += move_direction * _paddle_speed * delta

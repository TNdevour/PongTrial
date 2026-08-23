extends AnimatableBody2D

@export var _paddle_speed: float = 500.0

const PADDLE_GROUP: String = "paddles"

func _ready() -> void:
	add_to_group(PADDLE_GROUP)

func _physics_process(delta: float) -> void:
	var move_direction: float = Input.get_axis("move_up","move_down")	
	position.y += move_direction * _paddle_speed * delta

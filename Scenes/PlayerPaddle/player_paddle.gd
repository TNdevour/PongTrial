extends AnimatableBody2D

@export var _paddle_speed: float = 500.0
@onready var texture_rect: TextureRect = $TextureRect

const PADDLE_GROUP: String = "paddles"
const HEIGHT_PADDING: float = 20.0
var _paddle_half_height: float = 0.0
var _can_move: bool = false

func _ready() -> void:
	add_to_group(PADDLE_GROUP)
	SignalHub.on_start_game.connect(allow_paddle_movement)
	_paddle_half_height = texture_rect.size.x/2 - HEIGHT_PADDING

func _physics_process(delta: float) -> void:
	if !_can_move: return
	
	var move_direction: float = Input.get_axis("move_up","move_down")
	
	var new_y_pos:float = position.y + (move_direction * _paddle_speed * delta)
	new_y_pos = clamp(
		new_y_pos,
		get_viewport_rect().position.y + _paddle_half_height,
		get_viewport_rect().end.y - _paddle_half_height
		)
	position.y = new_y_pos

func allow_paddle_movement()-> void:
	_can_move = true
	

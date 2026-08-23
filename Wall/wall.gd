extends StaticBody2D

const WALL_GROUP: String = "walls"

func _ready() -> void:
	add_to_group(WALL_GROUP)
	

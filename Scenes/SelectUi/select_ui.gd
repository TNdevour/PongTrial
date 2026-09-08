extends Control

const EASY_MODE:String = "EASY"
const HARD_MODE:String = "HARD"
const MASTER = preload("uid://crt2twuo7gdkx")

func _ready() -> void:
	get_tree().paused = false

func _on_easy_mode_button_pressed() -> void:
	SignalHub.emit_on_difficulty_set(EASY_MODE)
	move_to_master()

func _on_hard_mode_button_pressed() -> void:
	SignalHub.emit_on_difficulty_set(HARD_MODE)
	move_to_master()

func move_to_master()-> void:
	get_tree().change_scene_to_packed(MASTER)

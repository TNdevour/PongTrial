extends Control

@onready var player_score_label: Label = $MarginContainer/ScoresHbox/HBoxContainer/Player_Score_Label
@onready var ai_score_label: Label = $MarginContainer/ScoresHbox/HBoxContainer2/Ai_Score_Label
@onready var game_over_label: Label = $MarginContainer/GameOverHbox/VBoxContainer/GameOverLabel
@onready var ready_hbox: HBoxContainer = $MarginContainer/ReadyHbox
@onready var scores_hbox: HBoxContainer = $MarginContainer/ScoresHbox
@onready var pause_hbox: HBoxContainer = $MarginContainer/PauseHbox
@onready var game_over_hbox: HBoxContainer = $MarginContainer/GameOverHbox
@onready var pause_timer: Timer = $PauseTimer
const SELECT_UI = preload("uid://bel6bmgiok3ja")

enum GameState{PLAYING, PAUSED, READY, GAMEOVER}
var _game_state:GameState = GameState.READY
const ZERO_PAD:int = 2

func _ready() -> void:
	SignalHub.on_ai_scored.connect(update_ai_score)
	SignalHub.on_player_scored.connect(update_player_score)
	SignalHub.on_game_over.connect(on_game_over)
	SignalHub.on_start_round.connect(on_start_round)
	
	update_ai_score()
	update_player_score()
	toggle_scores(false)
	toggle_pause_label(false)
	toggle_ready_label(true)
	toggle_gameover_label(false)

func update_ai_score()-> void:
	ai_score_label.text = "%s" %[str(ScoreManager.ai_score).pad_zeros(ZERO_PAD)]

func update_player_score()-> void:
	player_score_label.text = "%s" %[str(ScoreManager.player_score).pad_zeros(ZERO_PAD)]

func toggle_scores(is_shown:bool)-> void:
	scores_hbox.visible = is_shown

func toggle_ready_label(is_shown:bool)-> void:
	ready_hbox.visible = is_shown

func toggle_pause_label(is_shown:bool)-> void:
	pause_hbox.visible = is_shown

func toggle_gameover_label(is_shown:bool)-> void:
	game_over_hbox.visible = is_shown

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start") and _game_state == GameState.READY:
		pause_timer.start()
		toggle_ready_label(false)
		toggle_scores(true)
		_game_state = GameState.PLAYING
		SignalHub.emit_on_start_game()
		
	if (event.is_action_pressed("pause") or event.is_action_pressed("start") ) and _game_state == GameState.PLAYING and pause_timer.is_stopped():
		pause_timer.start()
		get_tree().paused = true
		toggle_pause_label(true)
		_game_state = GameState.PAUSED
		
	if (event.is_action_pressed("pause") or event.is_action_pressed("start") )  and _game_state == GameState.PAUSED and pause_timer.is_stopped():
		get_tree().paused = false
		toggle_pause_label(false)
		_game_state = GameState.PLAYING
		
	if event.is_action_pressed("quit") and _game_state == GameState.PAUSED:
		get_tree().quit()
	
	if event.is_action_pressed("start") and _game_state == GameState.GAMEOVER:
		get_tree().paused = false
		toggle_gameover_label(false)
		_game_state = GameState.PLAYING
		SignalHub.emit_on_game_restarted()
	
	if event.is_action_pressed("quit") and _game_state == GameState.GAMEOVER:
		get_tree().change_scene_to_packed(SELECT_UI)
	
func on_game_over(has_player_won:bool)-> void:
	get_tree().paused = true
	if has_player_won:
		game_over_label.text = "You Won!"
	else:
		game_over_label.text = "You lost..."
	toggle_gameover_label(true)
	_game_state = GameState.GAMEOVER

func on_start_round()-> void:
	update_ai_score()
	update_player_score()

#func _physics_process(_delta: float) -> void:
	#print("game_state: %s"%[GameState.find_key(_game_state)]);

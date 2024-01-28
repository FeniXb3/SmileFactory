extends Node2D

@export var ommit_start_menu = false
@export var level_scene : PackedScene
@onready var menu_layer = $MenuLayer
@onready var main_menu = %MainMenu
@onready var pause_menu = %PauseMenu
@onready var game_over_menu = %GameOverMenu
@onready var music_sound = $Music

@onready var level_parent = $LevelParent
var level : Node

func _ready():
	SignalBus.game_over.connect(_on_game_over)
	music_sound.play()
	
	if ommit_start_menu:
		_on_main_menu_start_game_pressed()
	
func _input(event):
	if (event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause")) and not pause_menu.visible:
		pause_menu.open_pause_menu()

func _on_main_menu_start_game_pressed():
	clear_level()
	
	level = level_scene.instantiate()
	level_parent.add_child(level)
	print("start")
	main_menu.hide()
	#music_sound.volume_db = -25
	music_sound.pitch_scale = 2

func _on_game_over():
	#main_menu.open_main_menu()
	game_over_menu.open_menu()
	
	#pause_menu.open_pause_menu()

func clear_level():
	if level:
		level_parent.remove_child(level)
		level.free()

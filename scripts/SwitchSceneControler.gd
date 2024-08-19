extends Node2D

signal scene_changed(scene_name)

@export var scene_name: String = "Menu"
var next_scene_name: String = ""
@onready var player_class_label = $PlayerClass

var game_parameters: Dictionary = {
	"player_class" = "harpon",
	"player_strength" = 1,
	"player_range" = 1,
	"player_reload_time" = 2,
	"player_life" = 3,
	"player_pos_x" = 0,
	"player_pos_y" = 0,
	"player_cell_x" = 0,
	"player_cell_y" = 0
}

var options_parameters: Dictionary = {
	"music_vol" = 100,
	"effects_vol" = 100
}

func _ready():
	print("SwitchSceneControler _ready called")

	# Vérifiez si les connexions existent déjà avant de les établir
	if (scene_name == "Menu"):
		if !$MenuBox/Sprite2D/MarginContainer/VBoxContainer/Start.is_connected("pressed", Callable(self, "_on_start_pressed")):
			$MenuBox/Sprite2D/MarginContainer/VBoxContainer/Start.connect("pressed", Callable(self, "_on_start_pressed"))
	
	if (scene_name == "CharacterChoice"):
		if !$Start.is_connected("pressed", Callable(self, "_on_start_pressed")):
			$Start.connect("pressed", Callable(self, "_on_start_pressed"))
			player_class_label.text = game_parameters.player_class
	
	if (scene_name == "Game"):
		if !$Player/Pause/MarginContainer/VBoxContainer/ToMainMenu.is_connected("pressed", Callable(self, "_on_to_main_menu_pressed")):
			$Player/Pause/MarginContainer/VBoxContainer/ToMainMenu.connect("pressed", Callable(self, "_on_to_main_menu_pressed"))


func load_parameters(new_game_parameters: Dictionary, new_options_parameters: Dictionary,):
	game_parameters = new_game_parameters
	options_parameters = new_options_parameters

func _on_start_pressed():
	print("pressed - ", scene_name)
	print("Emitting signal 'scene_changed' with: ", scene_name)
	if scene_name == "Menu":
		next_scene_name = "CharacterChoice"
	if scene_name == "CharacterChoice":
		game_parameters.player_strength = 1
		game_parameters.player_range = 1
		game_parameters.player_reload_time = 2
		game_parameters.player_life = 3
		game_parameters.player_pos_x = 0
		game_parameters.player_pos_y = 0
		game_parameters.player_cell_x = 0
		game_parameters.player_cell_y = 0
		next_scene_name = "Game"
	change_scene()


func _on_button_harpon_pressed():
	game_parameters.player_class = "harpon"
	player_class_label.text = game_parameters.player_class


func _on_button_epee_pressed():
	game_parameters.player_class = "epee"
	player_class_label.text = game_parameters.player_class


func _on_to_main_menu_pressed():
	next_scene_name = "Menu"
	change_scene()


func change_scene():
	emit_signal("scene_changed", scene_name, next_scene_name)

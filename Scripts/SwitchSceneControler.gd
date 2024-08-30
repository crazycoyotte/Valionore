extends Node2D

signal scene_changed(scene_name)

@export var scene_name: String = "Menu"
var next_scene_name: String = ""
@onready var player_class_label = $PlayerClass

var player_parameters: Dictionary = {
	"player_class" = "harpon",
	"player_strength" = 1,
	"player_range" = 1,
	"player_reload_time" = 2,
	"player_actual_life" = 3,
	"player_max_life" = 3,
	"player_pos_x" = 0,
	"player_pos_y" = 0,
	"player_cell_x" = 0,
	"player_cell_y" = 0
}

var options_parameters: Dictionary = {
	"music_vol" = 100,
	"effects_vol" = 100
}

var game_parameters: Dictionary = {
	"is_paused" = false
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
			player_class_label.text = player_parameters.player_class
	
	if (scene_name == "Game"):
		if !$Player/Pause/MarginContainer/VBoxContainer/ToMainMenu.is_connected("pressed", Callable(self, "_on_to_main_menu_pressed")):
			$Player/Pause/MarginContainer/VBoxContainer/ToMainMenu.connect("pressed", Callable(self, "_on_to_main_menu_pressed"))


# fonction faisant la mise à jour des paramètres
#Paramètres : new_game_parameters: Dictionary, new_options_parameters: Dictionary, new_game_parameters : Dictionary
#Retour : rien
#
func load_parameters(new_player_parameters: Dictionary, new_options_parameters: Dictionary, new_game_parameters : Dictionary):
	player_parameters = new_player_parameters
	options_parameters = new_options_parameters
	game_parameters = new_game_parameters
	

# fonction lors de l'appui sur le bouton start
#Paramètres : rien
#Retour : rien
#
func _on_start_pressed():
	print("pressed - ", scene_name)
	print("Emitting signal 'scene_changed' with: ", scene_name)
	if scene_name == "Menu":
		next_scene_name = "CharacterChoice"
	if scene_name == "CharacterChoice":
		player_parameters.player_strength = 1
		player_parameters.player_range = 1
		player_parameters.player_reload_time = 2
		player_parameters.player_actual_life = 3
		player_parameters.player_max_life = 3
		player_parameters.player_pos_x = 0
		player_parameters.player_pos_y = 0
		player_parameters.player_cell_x = 0
		player_parameters.player_cell_y = 0
		next_scene_name = "Game"
	change_scene()


# fonction lors de l'appui sur le bouton harpon
#Paramètres : rien
#Retour : rien
#
func _on_button_harpon_pressed():
	player_parameters.player_class = "harpon"
	player_class_label.text = player_parameters.player_class


# fonction lors de l'appui sur le bouton épée
#Paramètres : rien
#Retour : rien
#
func _on_button_epee_pressed():
	player_parameters.player_class = "epee"
	player_class_label.text = player_parameters.player_class


# fonction lors de l'appui sur le bouton Main Menu
#Paramètres : rien
#Retour : rien
#
func _on_to_main_menu_pressed():
	next_scene_name = "Menu"
	change_scene()



# fonction lançant le changement de scène
#Paramètres : rien
#Retour : rien
#
func change_scene():
	emit_signal("scene_changed", scene_name, next_scene_name)

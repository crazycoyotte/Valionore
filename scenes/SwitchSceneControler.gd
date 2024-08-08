extends Node2D

signal scene_changed(scene_name)

@export var scene_name = "Menu"



func _ready():
	print("SwitchSceneControler _ready called")

	# Vérifiez si les connexions existent déjà avant de les établir
	if (scene_name == "Menu"):
		if !$MenuBox/Sprite2D/MarginContainer/VBoxContainer/Start.is_connected("pressed", Callable(self, "_on_start_pressed")):
			$MenuBox/Sprite2D/MarginContainer/VBoxContainer/Start.connect("pressed", Callable(self, "_on_start_pressed"))
	
	if (scene_name == "CharacterChoice"):
		if !$Start.is_connected("pressed", Callable(self, "_on_start_pressed")):
			$Start.connect("pressed", Callable(self, "_on_start_pressed"))
	
	if (scene_name == "Game"):
		if !$Player/Pause/MarginContainer/VBoxContainer/ToMainMenu.is_connected("pressed", Callable(self, "_on_to_main_menu_pressed")):
			$Player/Pause/MarginContainer/VBoxContainer/ToMainMenu.connect("pressed", Callable(self, "_on_to_main_menu_pressed"))
	#$VBoxContainer/Volume.connect("pressed", Callable(self, "_on_button_volume_pressed"))
	#$VBoxContainer/Back.connect("pressed", Callable(self, "_on_button_back_pressed"))


func _on_start_pressed():
	print("pressed - ", scene_name)
	print("Emitting signal 'scene_changed' with: ", scene_name)
	emit_signal("scene_changed", scene_name)


func _on_button_harpon_pressed():
	pass # Replace with function body.



func _on_button_epee_pressed():
	pass # Replace with function body.


func _on_to_main_menu_pressed():
	print("pressed - ", scene_name)
	print("Emitting signal 'scene_changed' with: ", scene_name)
	emit_signal("scene_changed", scene_name)

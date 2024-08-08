extends Node

@onready var current_scene = $Menu

func _ready():
	print("SwitchScene _ready called")
	if current_scene.has_signal("scene_changed"):
		print("Signal 'scene_changed' exists in current_scene")
	else:
		print("Signal 'scene_changed' does NOT exist in current_scene")
	
	var result = current_scene.connect("scene_changed", Callable(self, "handle_scene_changed"))
	if result == OK:
		print("Successfully connected to 'scene_changed' signal")
	else:
		print("Failed to connect to 'scene_changed' signal")
	
func handle_scene_changed(current_scene_name: String):
	print("handle_scene_changed called with: ", current_scene_name)
	var next_scene_name: String
	var next_scene
	
	match current_scene_name:
		"Menu":
			next_scene_name = "CharacterChoice"
		"CharacterChoice":
			next_scene_name = "Game"
		"Game":
			next_scene_name = "Menu"
	#if current_scene_name == "Menu":
	#	next_scene_name = "CharacterChoice"
	#elif current_scene_name == "CharacterChoice":
	#	next_scene_name = "Game"
	#elif current_scene_name == "Game":
	#	next_scene_name = "Menu"
	#else:
	#	print("No valid scene to switch to")
	#	return  # Aucun changement de scène n'est nécessaire
	
	print("Loading next scene: ", next_scene_name)
	next_scene = load("res://scenes/" + next_scene_name + ".tscn").instantiate()
	if next_scene == null:
		print("Failed to load scene: ", next_scene_name)
		return

	add_child(next_scene)
	current_scene.queue_free()
	current_scene = next_scene
	# Connecter le signal pour la nouvelle scène
	current_scene.connect("scene_changed", Callable(self, "handle_scene_changed"))
	print("Switched to scene: ", next_scene_name)

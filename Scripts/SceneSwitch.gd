extends Node

@onready var current_scene = $Menu


# fonction au chargement
#Paramètres : aucun
#Retour : rien
#
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
	


# fonction faisant le changement de scene
#Paramètres : current_scene_name: String, next_scene_name: String
#Retour : rien
#
func handle_scene_changed(current_scene_name: String, next_scene_name: String):
	print("handle_scene_changed called with: ", current_scene_name)
	var next_scene
	print("Loading next scene: ", next_scene_name)
	next_scene = load("res://Scenes/" + next_scene_name + ".tscn").instantiate()
	print(next_scene_name + " instantiate : OK")
	transfer_data_between_scenes(current_scene, next_scene)
	if next_scene == null:
		print("Failed to load scene: ", next_scene_name)
		return

	add_child(next_scene)
	print(next_scene_name + " child creation : OK")
	current_scene.queue_free()
	current_scene = next_scene
	# Connecter le signal pour la nouvelle scène
	current_scene.connect("scene_changed", Callable(self, "handle_scene_changed"))
	print("Switched to scene: ", next_scene_name)

# fonction transférant les données
#Paramètres : old_scene, new_scene
#Retour : rien
#
func transfer_data_between_scenes(old_scene, new_scene):
	new_scene.load_parameters(old_scene.player_parameters, old_scene.options_parameters, old_scene.game_parameters)

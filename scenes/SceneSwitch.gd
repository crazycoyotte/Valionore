extends Node

@onready var current_scene = $CharacterChoice

func _ready():
	current_scene.connect("scene_changed", handle_scene_changed)
	
func handle_scene_changed(current_scene_name: String):
	var next_scene_name: String = "game"
	var next_scene
	
	next_scene = load("res://scenes/"+ next_scene_name +".tscn").instantiate()
	add_child(next_scene)
	current_scene.queue_free()
	current_scene = next_scene

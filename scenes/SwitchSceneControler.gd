extends Node2D

signal scene_changed(scene_name)

@export var scene_name = "scene"

func _on_start_pressed():
	emit_signal("scene_changed", scene_name)


func _on_button_harpon_pressed():
	pass # Replace with function body.



func _on_button_epee_pressed():
	pass # Replace with function body.

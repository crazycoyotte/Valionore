extends Control


#func _process(_delta):
	#$Sprite2D/MarginContainer.position.x = -(($Sprite2D/MarginContainer.size.x)/2)*$Sprite2D/MarginContainer.scale.x
	#$Sprite2D/MarginContainer.position.y = -(($Sprite2D/MarginContainer.size.y)/2)*$Sprite2D/MarginContainer.scale.y
	#print($Sprite2D/MarginContainer.get_transform())



func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/SceneSwitch.tscn")

func _on_options_pressed():
	$Sprite2D/MarginContainer.visible = false
	$Sprite2D/MarginContainer2.visible = true

func _on_back_pressed():
	$Sprite2D/MarginContainer2.visible = false
	$Sprite2D/MarginContainer.visible = true

func _on_quit_pressed():
	get_tree().quit()

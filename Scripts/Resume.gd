extends Button

@onready var player = $"../../../../"

func _process(_delta):
	if Input.is_action_pressed("pause"):
		grab_focus()
	
func _on_resume_pressed():
	player.pauseMenu()

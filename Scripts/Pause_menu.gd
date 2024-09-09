extends Control
@onready var player = $"../"

func _on_resume_pressed():
	player.pauseMenu()

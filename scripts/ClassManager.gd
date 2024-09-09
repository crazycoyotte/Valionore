extends Node2D
@onready var player = $"../"
@onready var game = $"../../"

func _ready() -> void:
	print("class du joueur : ", game.player_parameters.player_class)
	if game.player_parameters.player_class == "harpon":
			var player_sprite = preload("res://Scenes/ClassHarpoon.tscn")
			var new_bullet = player_sprite.instantiate()
			add_child(new_bullet)
		

func _physics_process(delta: float) -> void:
	pass

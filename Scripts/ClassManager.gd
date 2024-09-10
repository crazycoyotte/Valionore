extends Node2D
@onready var player = $"../"
@onready var game = $"../../"

func _ready() -> void:
	print("class du joueur : ", game.player_parameters.player_class)
	if game.player_parameters.player_class == "harpon":
			var player_sprite = preload("res://scenes/ClassHarpoon.tscn")
			var sprite_to_load = player_sprite.instantiate()
			add_child(sprite_to_load)
	if game.player_parameters.player_class == "epee":
			var player_sprite = preload("res://scenes/ClassEpee.tscn")
			var sprite_to_load = player_sprite.instantiate()
			add_child(sprite_to_load)

func _physics_process(_delta: float) -> void:
	pass

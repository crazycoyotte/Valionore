extends Area2D

@onready var player = $"../../../"

func _physics_process(_delta):
	var _enemies_in_range = get_overlapping_bodies()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
# fonction de tir
#Paramètres : aucun
#Retour : rien
#
#création d'un objet bullet
func shoot():
	if player.paused == false:
		pass
